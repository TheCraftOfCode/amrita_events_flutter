import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../onboarding.dart';

class StarCard extends StatelessWidget {
  const StarCard(
      {Key? key,
      required this.event_name,
      required this.time,
      required this.date});

  final String event_name, time, date;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: colors.cardBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: 250,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                event_name,
                style: GoogleFonts.nunitoSans(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: colors.headingTextColor),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      time,
                      style: GoogleFonts.nunitoSans(
                          fontSize: 20, color: colors.headingTextColor),
                    ),
                    Text(
                      date,
                      style: GoogleFonts.nunitoSans(
                          fontSize: 20, color: colors.headingTextColor),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FeaturesPage()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      'RSVP',
                      style: GoogleFonts.nunitoSans(
                          fontSize: 20,
                          color: colors.scaffoldColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  style:
                      ElevatedButton.styleFrom(primary: colors.headingTextColor),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
