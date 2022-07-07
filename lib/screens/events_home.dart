import 'dart:async';
import 'dart:convert';

import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:amrita_events_flutter/widgets/custom_sliver_widget.dart';
import 'package:amrita_events_flutter/widgets/top_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/event_model.dart';
import '../utils/http_modules.dart';
import '../widgets/starred_card.dart';
import 'event_page.dart';

class EventsHome extends StatefulWidget {
  const EventsHome({Key? key}) : super(key: key);

  @override
  _EventsHomeState createState() => _EventsHomeState();
}

class _EventsHomeState extends State<EventsHome>
    with AutomaticKeepAliveClientMixin {
  //root data
  List<EventModel> data = [];
  List<EventModel> dataSearch = [];

  //list depending on root data
  List<Widget> eventList = [];
  List<EventModel> rsvpList = [];
  List<EventModel> upcomingList = [];

  _compareDates(String date) {
    DateTime dateParsed = DateTime.parse(date);
    DateTime currentDate = DateTime.now();
    //event date - current date, required is 1
    return dateParsed.compareTo(currentDate);
  }

  //call this method if data is updated to refresh all data without having to pull new data from the server again
  _buildDataList() {
    setState(() {
      eventList.clear();
      rsvpList.clear();
      upcomingList.clear();
    });
    for (var i in data) {
      setState(() {
        eventList.add(StarCard(
          model: i,
          rsvp: _rsvp,
          star: _starEvent,
        ));
        if (i.rsvp) {
          rsvpList.add(i);
        }
        if (_compareDates(i.dateUnparsed) > 0) {
          upcomingList.add(i);
        }
        if (i.starred) {}
      });
    }
  }

  _getData() async {
    setState(() {
      data.clear();
      dataSearch.clear();
    });

    var response =
        await makePostRequest(null, "/event/getEvents", null, true, context);

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body)["data"]; //List Data
      for (var i in responseData) {
        setState(() {
          var parseData = EventModel.fromJSON(i);
          data.add(parseData);
          dataSearch.add(parseData);
        });
      }
      _buildDataList();
    }
  }

  _rsvp(EventModel model) async {
    var response = await makePostRequest(
        json.encode({"eventId": model.id}), "/rsvp/rsvp", null, true, context);

    if (response.statusCode == 200) {
      //TODO: Show message for successful RSVP
      model.rsvp = true;

      //updating list to refresh new changed done to the list
      _buildDataList();
    }
  }

  _starEvent(EventModel model) async {
    //already starred
    if (!model.starred) {
      var response = await makePostRequest(json.encode({"eventId": model.id}),
          "/event/starEvent", null, true, context);

      if (response.statusCode == 200) {
        //TODO: Show message for successful RSVP
        model.starred = true;

        //updating list to refresh new changed done to the list
        _buildDataList();
      }
    }

    //not starred
    else {
      var response = await makePostRequest(json.encode({"eventId": model.id}),
          "/event/removeStarredEvent", null, true, context);

      if (response.statusCode == 200) {
        //TODO: Show message for successful RSVP
        model.starred = false;

        //updating list to refresh new changed done to the list
        _buildDataList();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.scaffoldColor,
      body: RefreshIndicator(
        onRefresh: () async {
          await _getData();
        },
        child: CustomSliverView(
          columnList: [
            TopBarWidget(
              icon: Icons.home_outlined,
              onChanged: (value) {
                data.clear();
                if (value != null) {
                  if (value.isEmpty) {
                    setState(() {
                      data.addAll(dataSearch);
                    });
                  } else {
                    setState(() {
                      data = dataSearch
                          .where((i) => i.title
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                    });
                  }
                } else {
                  setState(() {
                    data.addAll(dataSearch);
                  });
                }
                _buildDataList();
              },
              title: 'Events',
            ),
            data.isNotEmpty
                ? YesEventsWidget(
                    data: eventList,
                    rsvpList: rsvpList,
                    upcomingList: upcomingList,
                    rsvp: _rsvp,
                  )
                : const NoEventsWidget()
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class HorizontalPageView extends StatefulWidget {
  const HorizontalPageView({Key? key, required this.list, required this.rsvp})
      : super(key: key);
  final List<EventModel> list;
  final void Function(EventModel) rsvp;

  @override
  State<HorizontalPageView> createState() => _HorizontalPageViewState();
}

class _HorizontalPageViewState extends State<HorizontalPageView> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return widget.list.isNotEmpty
        ? SizedBox(
            height: (MediaQuery.of(context).size.height * 0.7) / 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: PageView.builder(
                padEnds: false,
                itemCount: widget.list.length,
                controller: PageController(viewportFraction: 0.55),
                onPageChanged: (int index) => setState(() => _index = index),
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EventPage(
                                      model: widget.list[index],
                                      rsvp: widget.rsvp,
                                    )));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Card(
                              elevation: 6,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: Text(
                                  "Card ${index + 1}",
                                  style: const TextStyle(fontSize: 32),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, top: 8),
                              child: Text(
                                widget.list[index].title,
                                maxLines: 2,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, top: 10),
                            child: Text(
                              widget.list[index].date,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.grey),
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        : const Padding(
            padding: EdgeInsets.all(32.0),
            child: Center(
              child: Text(
                "No events to show!",
                style: TextStyle(color: Colors.white38),
              ),
            ),
          );
  }
}

class YesEventsWidget extends StatefulWidget {
  YesEventsWidget(
      {Key? key,
      required this.data,
      required this.rsvpList,
      required this.upcomingList,
      required this.rsvp})
      : super(key: key);

  List<Widget> data;
  List<EventModel> rsvpList;
  List<EventModel> upcomingList;
  final void Function(EventModel) rsvp;

  @override
  State<YesEventsWidget> createState() => _YesEventsWidgetState();
}

class _YesEventsWidgetState extends State<YesEventsWidget> {
  String chosenOption = "ALL EVENTS";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
            const Padding(
              padding: EdgeInsets.only(left: 28, top: 30),
              child: Text(
                "Upcoming",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            HorizontalPageView(
              list: widget.upcomingList,
              rsvp: widget.rsvp,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 28, top: 16),
              child: Text(
                "RSVP'd Events",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            HorizontalPageView(
              list: widget.rsvpList,
              rsvp: widget.rsvp,
            ),
            _dropDown(
                ["ALL EVENTS", "STARRED EVENTS", "RSVP'D EVENTS"], chosenOption,
                (newValue) {
              setState(() {
                chosenOption = newValue;
              });
            }),
          ] +
          widget.data,
    );
  }
}

Widget _dropDown(listOfOptions, chosenOption, onChanged) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: DropdownButtonHideUnderline(
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButton<dynamic>(
          dropdownColor: colors.scaffoldColor,
          icon: const Padding(
            padding: EdgeInsets.only(right: 5),
            child: Icon(
              // Add this
              Icons.menu_open, // Add this
              // color: colors.errorColor, // Add this
            ),
          ),
          value: chosenOption,
          isExpanded: true,
          items: listOfOptions.map<DropdownMenuItem>((value) {
            return DropdownMenuItem(
              value: value,
              child: Text(
                value,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            );
          }).toList(),
          onChanged: onChanged,
          style: GoogleFonts.poppins(
            color: Colors.white,
            // decorationColor: colors.errorColor
          ),
        ),
      ),
    ),
  );
}

class NoEventsWidget extends StatelessWidget {
  const NoEventsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
          child: Image(
            image: const AssetImage('assets/no_events.png'),
            height: MediaQuery.of(context).size.width * 0.9,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Center(
              child: Text(
            'Amazing events are being planned by amazing people. Please check in later!',
            textAlign: TextAlign.center,
            style: GoogleFonts.nunitoSans(
                fontSize: 22,
                fontWeight: FontWeight.normal,
                color: colors.headingTextColor),
          )),
        ),
      ],
    );
  }
}

//TODO: Have to add refresh on pull and empty / no network states
