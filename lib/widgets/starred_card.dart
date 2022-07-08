import 'package:amrita_events_flutter/screens/event_page.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/event_model.dart';
import '../screens/onboarding.dart';
import 'network_image.dart';

class StarCard extends StatelessWidget {
  const StarCard(
      {Key? key, required this.model, required this.rsvp, required this.star});

  final EventModel model;
  final void Function(EventModel) rsvp;
  final void Function(EventModel) star;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EventPage(
                      model: model,
                      rsvp: rsvp,
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
                SizedBox(
                  height: 250,
                  width: double.maxFinite,
                  child: Stack(
                    children: [
                      Positioned.fill(child: networkImage(model.posterUrl)),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: colors.cardBackgroundColor,
                            child: InkWell(
                              onTap: () {
                                star(model);
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 8),
                                    child: Icon(
                                      model.starred ? Icons.star : Icons.star_border,
                                      color: Colors.white54,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      model.starred ? "Already Starred" : "Star",
                                      style: GoogleFonts.nunitoSans(
                                          color:Colors.white70,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
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
