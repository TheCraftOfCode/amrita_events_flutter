import 'dart:convert';

import 'package:amrita_events_flutter/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:amrita_events_flutter/utils/constants.dart' as constants;
import 'package:google_fonts/google_fonts.dart';
import 'package:amrita_events_flutter/utils/http_modules.dart';

class PublishResultsPage extends StatefulWidget {
  const PublishResultsPage({Key? key}) : super(key: key);

  @override
  _PublishResultsPageState createState() => _PublishResultsPageState();
}

class _PublishResultsPageState extends State<PublishResultsPage> {
  List<EventModel> allEventsList = [];

  // getListData(http.Response data, bool reloadPage) {
  //   if (data.statusCode != 200) {
  //     return;
  //   }

  //  Map<String, dynamic> decodedData = jsonDecode(data.body);

    // allEventsList.clear();
  //   for (var i in decodedData['event']) {
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
  //     EventData data = EventData(
  //         id: i['_id'],
  //         eventName: i['eventName'],
  //         eventDate: i['date'],
  //         time: i['time'],
  //         location: i['location'],
  //         rules: i['rules'],
  //         judgingCriteria: i['judgingCriteria'],
  //         eventType: i['eventType'],
  //         registrationLink: i['registrationLink'],
  //         submissionLink: i['submissionLink'],
  //         eventOver: i['eventOver'],
  //         eventDescription: i['eventDescription'],
  //         results: resultData);
  //     allEventsList.add(data);
  //   }
  //   sortEventAscending(allEventsList);
  //   if (reloadPage) {
  //     setState(() {});
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: makePostRequest(null, "/getAllResults", null, true,
              context: context),
          builder: (context, AsyncSnapshot<http.Response> data) {
            if (data.hasData) {
              getListData(data.requireData, false);
            }
            if (data.hasData) {
              return RefreshIndicator(
                color: colors.accentColor,
                onRefresh: () async {
                  http.Response data = await makePostRequest(
                      null, "/getAllResults", null, true,
                      context: context);
                  getListData(data, true);
                },
                child: Container(
                  height: double.maxFinite,
                  // decoration: constants.gradientDecoration,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 70.0, bottom: 20, left: 20),
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Publish or Edit Results',
                                    style: GoogleFonts.nunito(
                                        fontSize: 30,
                                        color: colors.primaryTextColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Click on an event to publish results',
                                    style: GoogleFonts.nunito(
                                      fontSize: 17,
                                      color: colors.primaryTextColor,
                                    ),
                                  )
                                ],
                              )),
                        ),
                        // if (allEventsList.isNotEmpty)
                        //   ListView.builder(
                        //     shrinkWrap: true,
                        //     physics: const NeverScrollableScrollPhysics(),
                        //     itemCount: allEventsList.length,
                        //     itemBuilder: (_, i) {
                        //       return MainContentCardWidget(
                        //         cardTitle: allEventsList[i].eventName,
                        //         cardSubTitle: allEventsList[i].eventType,
                        //         onTap: () {
                        //           Navigator.push(
                        //               context,
                        //               MaterialPageRoute(
                        //                   builder: (context) => PublishResults(
                        //                       eventData: allEventsList[i],
                        //                       onPublishSuccess: () {})));
                        //         },
                        //         cardDate: allEventsList[i].eventDate,
                        //       );
                        //     },
                        //   )
                        // else
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
                                      top: 20.0,
                                      bottom: 50,
                                      left: 30,
                                      right: 35),
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
                                    alignment: Alignment.topRight,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'TAKE ME BACK',
                                          style: GoogleFonts.nunito(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        )))
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Container(
                // decoration: constants.gradientDecoration,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(child: CircularProgressIndicator()),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: Text(
                          'Please wait...',
                          style: GoogleFonts.nunito(
                              color: colors.primaryTextColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 17),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
          }),
    );
  }
}