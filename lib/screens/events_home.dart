import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:amrita_events_flutter/widgets/custom_sliver_widget.dart';
import 'package:amrita_events_flutter/widgets/top_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/event_model.dart';
import '../utils/constants.dart';
import '../widgets/drop_down.dart';
import '../widgets/network_image.dart';
import '../widgets/starred_card.dart';
import 'event_page.dart';

class EventsHome extends StatefulWidget {
  const EventsHome(
      {Key? key,
      required this.data,
      required this.refresh,
      required this.rsvp,
      required this.star})
      : super(key: key);
  final List<EventModel> data;
  final Function refresh;
  final Function(EventModel) rsvp;
  final Function(EventModel) star;

  @override
  EventsHomeState createState() => EventsHomeState();
}

class EventsHomeState extends State<EventsHome>
    with AutomaticKeepAliveClientMixin {
  //root data
  List<EventModel> dataSearch = [];

  //list depending on root data
  List<Widget> cultural = [];
  List<Widget> technical = [];
  List<Widget> spiritual = [];
  List<Widget> mainWidgetList = [];

  List<EventModel> rsvpList = [];
  List<EventModel> upcomingList = [];

  String searchPattern = "";

  _compareDates(String date) {
    DateTime dateParsed = DateTime.parse(date);
    DateTime currentDate = DateTime.now();
    //event date - current date, required is 1
    return dateParsed.compareTo(currentDate);
  }

  //call this method if data is updated to refresh all data without having to pull new data from the server again
  buildDataList(bool search) {
    cultural.clear();
    technical.clear();
    spiritual.clear();
    mainWidgetList.clear();

    rsvpList.clear();
    upcomingList.clear();
    if (!search) {
      dataSearch.clear();
      dataSearch.addAll(widget.data);
    }
    for (var i in dataSearch) {
      setState(() {
        var card = StarCard(
          model: i,
          rsvp: widget.rsvp,
          star: widget.star,
        );

        //three conditions for three types of events
        mainWidgetList.add(card);
        if (i.eventType == "CULTURAL") {
          cultural.add(card);
        } else if (i.eventType == "TECHNICAL") {
          technical.add(card);
        } else if (i.eventType == "SPIRITUAL") {
          spiritual.add(card);
        }

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

  rebuildSearchData(){
    if(searchPattern.isNotEmpty){
      filterSearchData(searchPattern);
    }
  }

  filterSearchData(value){
    dataSearch.clear();
    if (value != null) {
      if (value.isEmpty) {
        setState(() {
          dataSearch.addAll(widget.data);
        });
      } else {
        setState(() {
          dataSearch = widget.data
              .where((i) => i.title
              .toLowerCase()
              .contains(value.toLowerCase()))
              .toList();
        });
      }
    } else {
      setState(() {
        dataSearch.addAll(widget.data);
      });
    }
    buildDataList(true);
  }

  @override
  void initState() {
    super.initState();
    buildDataList(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.scaffoldColor,
      body: RefreshIndicator(
        onRefresh: () async {
          await widget.refresh();
        },
        child: CustomSliverView(
          columnList: [
            TopBarWidget(
              onChanged: (value) {
                searchPattern = value ?? "";
                filterSearchData(value);
              },
              title: 'Events',
            ),
            dataSearch.isNotEmpty
                ? YesEventsWidget(
                    rsvpList: rsvpList,
                    upcomingList: upcomingList,
                    rsvp: widget.rsvp,
                    spiritual: spiritual,
                    technical: technical,
                    cultural: cultural,
                    allWidgets: mainWidgetList,
                  )
                : const NoEventsWidget()
          ],
        ),
      ),
    );
  }

  @override
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
                controller: PageController(viewportFraction: 0.4),
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
                            child: networkImage(widget.list[index].posterUrl),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, top: 8),
                            child: Text(
                              widget.list[index].title,
                              maxLines: 1,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                              overflow: TextOverflow.ellipsis,
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
  const YesEventsWidget(
      {Key? key,
      required this.cultural,
      required this.spiritual,
      required this.technical,
      required this.rsvpList,
      required this.upcomingList,
      required this.rsvp,
      required this.allWidgets})
      : super(key: key);

  final List<Widget> cultural;
  final List<Widget> technical;
  final List<Widget> spiritual;
  final List<Widget> allWidgets;

  final List<EventModel> rsvpList;
  final List<EventModel> upcomingList;
  final void Function(EventModel) rsvp;

  @override
  State<YesEventsWidget> createState() => _YesEventsWidgetState();
}

class _YesEventsWidgetState extends State<YesEventsWidget> {
  String chosenOption = "ALL EVENTS";

  final List<Widget> widgetList = [];

  initList() {
    widgetList.clear();
    if (chosenOption == eventOptions[0]) {
      widgetList.addAll(widget.allWidgets);
    } else if (chosenOption == eventOptions[1]) {
      widgetList.addAll(widget.cultural);
    } else if (chosenOption == eventOptions[2]) {
      widgetList.addAll(widget.technical);
    } else if (chosenOption == eventOptions[3]) {
      widgetList.addAll(widget.spiritual);
    }
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant YesEventsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    initList();
  }

  @override
  void initState() {
    super.initState();
    initList();
  }

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
                list: widget.upcomingList.reversed.toList(),
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
                list: widget.rsvpList.reversed.toList(),
                rsvp: widget.rsvp,
              ),
              dropDown(eventOptions, chosenOption, (newValue) {
                setState(() {
                  chosenOption = newValue;
                  initList();
                });
              }),
            ] +
            widgetList.reversed.toList());
  }
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

//TODO: Have to add empty / no network states
