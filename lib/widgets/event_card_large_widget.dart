import 'package:flutter/material.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:google_fonts/google_fonts.dart';

class EventCardLarge extends StatefulWidget {
  const EventCardLarge({Key? key, required this.title, required this.time, required this.date}) : super(key: key);

  final String title;
  final String time;
  final String date;
  @override
  State<EventCardLarge> createState() => _EventCardLargeState();
}

class _EventCardLargeState extends State<EventCardLarge> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 10,
      color: colors.cardBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: colors.headingTextColor,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                widget.title,
                style: GoogleFonts.nunitoSans(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: colors.headingTextColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.time,
                        style: GoogleFonts.nunitoSans(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: colors.headingTextColor),
                      ),
                      Text(
                        widget.date,
                        style: GoogleFonts.nunitoSans(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: colors.headingTextColor),
                      ),
                    ],
                  ),
                  Expanded(child: Container()),
                  ElevatedButton(
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'RSVP',
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: colors.scaffoldColor),
                        ),
                      ),
                  style: ElevatedButton.styleFrom(
                    primary: colors.headingTextColor
                  ),)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
