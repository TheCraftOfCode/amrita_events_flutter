import 'package:amrita_events_flutter/screens/event_page.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/event_model.dart';
import '../screens/onboarding.dart';

class StarCard extends StatelessWidget {
  const StarCard({Key? key, required this.model, required this.rsvp});

  final EventModel model;
  final void Function(EventModel) rsvp;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EventPage(
                      model: model, rsvp: rsvp,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 10,
          color: colors.cardBackgroundColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  height: 250,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      model.title,
                      style: GoogleFonts.nunitoSans(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: colors.headingTextColor),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          model.time,
                          style: GoogleFonts.nunitoSans(
                              fontSize: 20, color: colors.headingTextColor),
                        ),
                        Text(
                          model.date,
                          style: GoogleFonts.nunitoSans(
                              fontSize: 20, color: colors.headingTextColor),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: !model.rsvp
                          ? () {
                              rsvp(model);
                            }
                          : null,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          model.rsvp ? 'Already RSVPd' : 'RSVP',
                          style: GoogleFonts.nunitoSans(
                              color: model.rsvp
                                  ? Colors.white38
                                  : colors.scaffoldColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: colors.headingTextColor),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
