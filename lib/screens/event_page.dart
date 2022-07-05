import 'package:amrita_events_flutter/models/event_model.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:amrita_events_flutter/widgets/custom_sliver_widget.dart';
import 'package:amrita_events_flutter/widgets/top_bar_widget_with_back_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key? key, required this.model}) : super(key: key);

  final EventModel model;

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.scaffoldColor,
      body: CustomSliverView(
        columnList: [
          TopBarWidgetWithBackButton(
              title: widget.model.title, icon: Icons.arrow_back_ios_rounded),
          Padding(
              padding: const EdgeInsets.only(
                  top: 40, left: 15, right: 15, bottom: 30),
              child: Container(
                height: 500,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: colors.headingTextColor,
                    width: 20,
                  ),
                ),
              )),
          Padding(
            padding:
                const EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 30),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'HOST: ',
                    style: GoogleFonts.nunitoSans(
                        color: colors.eventCardItemTitle, fontSize: 20),
                  ),
                  flex: 2,
                ),
                Expanded(
                  child: Text(
                    'Association of students of computer science for information interchange (ASCII) ',
                    style: GoogleFonts.nunitoSans(
                        color: colors.headingTextColor, fontSize: 20),
                  ),
                  flex: 6,
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 30, right: 30, bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'VENUE: ',
                    style: GoogleFonts.nunitoSans(
                        color: colors.eventCardItemTitle, fontSize: 20),
                  ),
                  flex: 2,
                ),
                Expanded(
                  child: Text(
                    widget.model.location,
                    style: GoogleFonts.nunitoSans(
                        color: colors.headingTextColor, fontSize: 20),
                  ),
                  flex: 6,
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 30, right: 30, bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'DATE: ',
                    style: GoogleFonts.nunitoSans(
                        color: colors.eventCardItemTitle, fontSize: 20),
                  ),
                  flex: 2,
                ),
                Expanded(
                  child: Text(
                    widget.model.date,
                    style: GoogleFonts.nunitoSans(
                        color: colors.headingTextColor, fontSize: 20),
                  ),
                  flex: 6,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
            child: Text(
              widget.model.description,
              textAlign: TextAlign.justify,
              style: GoogleFonts.nunitoSans(
                  fontSize: 23, color: colors.headingTextColor),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'RSVP',
                  style: GoogleFonts.nunitoSans(
                      color: colors.scaffoldColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              style: ElevatedButton.styleFrom(primary: colors.headingTextColor),
            ),
          ),
          const SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}
