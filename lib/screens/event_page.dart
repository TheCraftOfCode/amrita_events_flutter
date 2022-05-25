import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:amrita_events_flutter/widgets/custom_sliver_widget.dart';
import 'package:amrita_events_flutter/widgets/top_bar_widget_with_back_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

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
          const TopBarWidgetWithBackButton(
              title: 'Title', icon: Icons.arrow_back_ios_rounded),
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
                    'Amriteshwari Hall',
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
                    '8th - 9th April 2021',
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
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit ut aliquam, purus sit amet luctus venenatis, lectus magna fringilla urna, porttitor rhoncus dolor purus non enim praesent elementum facilisis leo, vel fringilla est ullamcorper eget nulla facilisi etiam dignissim diam quis enim lobortis scelerisque fermentum dui faucibus in ornare quam viverra',
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
          const SizedBox(height: 100,)
        ],
      ),
    );
  }
}
