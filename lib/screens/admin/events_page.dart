import 'dart:convert';

import 'package:amrita_events_flutter/models/event_model.dart';
import 'package:amrita_events_flutter/models/results_model.dart';
import 'package:amrita_events_flutter/screens/admin/add_event.dart';
import 'package:amrita_events_flutter/utils/get_event_svg.dart';
import 'package:amrita_events_flutter/utils/http_modules.dart';
import 'package:amrita_events_flutter/utils/utils.dart';
import 'package:amrita_events_flutter/widgets/alert_dialog.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:amrita_events_flutter/utils/constants.dart' as constants;
import 'package:http/http.dart' as http;
import 'package:oktoast/oktoast.dart';

import '../event_page.dart';

class EventsList extends StatefulWidget {
  const EventsList({Key? key}) : super(key: key);

  @override
  _EventsListState createState() => _EventsListState();
}

class _EventsListState extends State<EventsList> {
  final List allEventsList = [];
  int focusedPage = 0;

  @override
  void initState() {
    super.initState();
  }

  // getListData(http.Response data, bool reloadPage) {
  //   if (data.statusCode != 200) {
  //     return;
  //   }

  //Map<String, dynamic> decodedData = jsonDecode(data.body);

  //allEventsList.clear();
  //   for (var i in decodedData['data']) {
  //     List<ResultsModel> resultData = [];
  //     if (i['results'] != null || i['results'].length != 0) {
  //       for (var result in i['results']) {
  //         resultData.add(ResultsModel(
  //             name: result['name'],
  //             rollNumber: result['rollNumber'],
  //             position: result['position'],
  //             house: result['house']));
  //       }
  //     }
  //   //   EventData data = EventData(
  //   //       id: i['_id'],
  //   //       eventName: i['eventName'],
  //   //       eventDate: i['date'],
  //   //       time: i['time'],
  //   //       location: i['location'],
  //   //       rules: i['rules'],
  //   //       judgingCriteria: i['judgingCriteria'],
  //   //       eventType: i['eventType'],
  //   //       registrationLink: i['registrationLink'],
  //   //       submissionLink: i['submissionLink'],
  //   //       eventPosterURL: i['eventPosterURL'] ?? "",
  //   //       eventOver: i['eventOver'],
  //   //       eventDescription: i['eventDescription'],
  //   //       results: resultData);
  //   //
  //   //   allEventsList.add(data);
  //   // }
  //   // sortEventAscending(allEventsList);
  //   // if (reloadPage) {
  //   //   setState(() {});
  //   // }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => AddEvent(
          //
          //     );
        },
        child: const Icon(Icons.add),
      ),
      body: SizedBox(
        height: double.maxFinite,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //TODO: Add appbar with search and notifications
              Padding(
                padding: const EdgeInsets.only(top: 70.0, bottom: 20, left: 20),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Events (admin)',
                          style: GoogleFonts.nunito(
                              fontSize: 30,
                              color: colors.primaryTextColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Choose an event to edit it\'s details.',
                          style: GoogleFonts.nunito(
                              fontSize: 17, color: colors.primaryTextColor),
                        ),
                      ],
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              if (allEventsList.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: allEventsList.length,
                  itemBuilder: (_, i) {
                    return _MainContentCardWidget(
                      cardTitle: allEventsList[i].eventName,
                      cardSubTitle: allEventsList[i].eventType,
                      eventType: allEventsList[i].eventType,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddEvent(
                                      eventData: allEventsList[i],
                                      eventUpdate: true,
                                    )));
                      },
                      cardDate: allEventsList[i].eventDate,
                      removeData: () {
                        setState(() {
                          allEventsList.removeAt(i);
                        });
                      },
                      id: allEventsList[i].id,
                    );
                  },
                )
              else
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                          child: Image.asset(
                        'assets/events_empty.png',
                        fit: BoxFit.contain,
                      )),
                      Text(
                        "Nothing to see here",
                        style: GoogleFonts.nunito(
                            fontSize: 25,
                            color: colors.primaryTextColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, bottom: 50, left: 30, right: 35),
                        child: Text(
                          "No events have been published so far, do check in later (or create some!). Cheers!",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(
                            fontSize: 17,
                            color: colors.primaryTextColor,
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'TAKE ME BACK',
                                style: GoogleFonts.nunito(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              )))
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MainContentCardWidget extends StatefulWidget {
  const _MainContentCardWidget(
      {Key? key,
      required this.cardSubTitle,
      required this.cardTitle,
      required this.cardDate,
      required this.onTap,
      required this.id,
      required this.removeData,
      required this.eventType})
      : super(key: key);
  final String cardTitle;
  final String cardSubTitle;
  final String cardDate;
  final VoidCallback onTap;
  final VoidCallback removeData;
  final String id;
  final String eventType;

  @override
  _MainContentCardWidgetState createState() => _MainContentCardWidgetState();
}

class _MainContentCardWidgetState extends State<_MainContentCardWidget> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            var horizontalCenteredDisplacement = constraints.maxWidth * 0.3;
            return Stack(
              children: [
                Positioned.fill(
                  left: (horizontalCenteredDisplacement) / 2,
                  child: InkWell(
                    child: Card(
                      elevation: 10,
                      color: colors.cardBackgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: InkWell(
                        onTap: widget.onTap,
                        borderRadius: BorderRadius.circular(10.0),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: (horizontalCenteredDisplacement / 2) + 15,
                              top: 20,
                              bottom: 15,
                              right: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      widget.cardTitle,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: GoogleFonts.raleway(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: AutoSizeText(
                                        widget.cardSubTitle,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.raleway(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 4),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: colors.dividerColor),
                                      height: 4.0,
                                      width: 32.0,
                                    ),
                                    Expanded(child: Container()),
                                    AutoSizeText(
                                      widget.cardDate,
                                      minFontSize: 15,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        color: colors.primaryTextColor,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              IconButton(
                                color: Colors.red,
                                padding: EdgeInsets.zero,
                                splashRadius: 15,
                                icon: const Icon(
                                  Icons.delete_forever,
                                  size: 25,
                                ),
                                onPressed: () {
                                  setState(() {
                                    displayDialog(context, "Yes", "No",
                                        () async {
                                      // Navigator.of(context).pop();
                                      // final response = await makePostRequest(
                                      //     json.encode({"id": widget.id}),
                                      //     "/deleteEvent",
                                      //     null,
                                      //     true,
                                      //     context: context);
                                      // if (response.statusCode == 200) {
                                      //   widget.removeData();
                                      //   showToast(
                                      //       "Deleted event successfully!");
                                      // } else {
                                      //   showToast("Could not delete event!");
                                      // }
                                    }, "Delete Event",
                                        "Are you sure you want to delete this event?");
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  child: getEventImage(
                      widget.eventType, horizontalCenteredDisplacement),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
