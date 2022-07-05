import 'dart:convert';

import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:amrita_events_flutter/widgets/custom_sliver_widget.dart';
import 'package:amrita_events_flutter/widgets/starred_card.dart';
import 'package:amrita_events_flutter/widgets/top_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/event_model.dart';
import '../utils/http_modules.dart';
import 'event_page.dart';

class EventsHome extends StatefulWidget {
  final bool yesEvents;

  const EventsHome({Key? key, required this.yesEvents}) : super(key: key);

  @override
  _EventsHomeState createState() => _EventsHomeState();
}

class _EventsHomeState extends State<EventsHome> {
  List<EventModel> data = [];
  List<Widget> eventList = [];
  List<EventModel> rsvpList = [];
  List<EventModel> upcomingList = [];

  _compareDates(String date) {
    DateTime dateParsed = DateTime.parse(date);
    DateTime currentDate = DateTime.now();
    //event date - current date, required is 1
    return dateParsed.compareTo(currentDate);
  }

  _getData() async {
    setState(() {
      data.clear();
      eventList.clear();
      rsvpList.clear();
      upcomingList.clear();
    });

    var response =
        await makePostRequest(null, "/event/getEvents", null, true, context);

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body)["data"]; //List Data
      for (var i in responseData) {
        setState(() {
          var parsedData = EventModel.fromJSON(i);
          data.add(parsedData);
          eventList.add(StarCard(
            model: parsedData,
          ));
          if (parsedData.rsvp) {
            rsvpList.add(parsedData);
          }
          if (_compareDates(i['dateUnparsed']) > 0) {
            upcomingList.add(parsedData);
          }
        });
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
      body: CustomSliverView(
        columnList: [
          const TopBarWidget(
            icon: Icons.home_outlined,
            title: 'Events',
          ),
          widget.yesEvents == false
              ? YesEventsWidget(
                  data: eventList,
                  rsvpList: rsvpList,
                  upcomingList: upcomingList)
              : const NoEventsWidget()
        ],
      ),
    );
  }
}

class HorizontalPageView extends StatefulWidget {
  const HorizontalPageView({Key? key, required this.list}) : super(key: key);
  final List<EventModel> list;

  @override
  State<HorizontalPageView> createState() => _HorizontalPageViewState();
}

class _HorizontalPageViewState extends State<HorizontalPageView> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return widget.list.isNotEmpty ? SizedBox(
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
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EventPage(
                            model: widget.list[index],
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
                          style:
                              const TextStyle(color: Colors.white, fontSize: 20),
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
    ) : Padding(
      padding: const EdgeInsets.all(32.0),
      child: const Center(child: Text("No events to show!", style: TextStyle(color: Colors.white38),),),
    );
  }
}

class YesEventsWidget extends StatefulWidget {
  YesEventsWidget(
      {Key? key,
      required this.data,
      required this.rsvpList,
      required this.upcomingList})
      : super(key: key);

  List<Widget> data;
  List<EventModel> rsvpList;
  List<EventModel> upcomingList;

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
            HorizontalPageView(list: widget.upcomingList),
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
