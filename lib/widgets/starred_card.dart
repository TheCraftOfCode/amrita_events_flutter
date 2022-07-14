import 'package:amrita_events_flutter/screens/event_page.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/event_model.dart';
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
          elevation: 20,
          color: colors.cardBackgroundColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                            elevation: 10,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            color: colors.cardBackgroundColor.withOpacity(1.0),
                            child: InkWell(
                              onTap: () {
                                star(model);
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Icon(
                                      model.starred ? Icons.star : Icons.star_border,
                                      color: model.starred ? colors.accentColor : Colors.white54,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      model.starred ? "Starred" : "Star",
                                      style: GoogleFonts.nunitoSans(
                                          color:model.starred ? colors.accentColor : Colors.white54,
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
                  padding: const EdgeInsets.only(top: 20.0,bottom: 5.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      model.title,
                      style: GoogleFonts.nunitoSans(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                          color: colors.headingTextColor),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.time,
                          style: GoogleFonts.nunitoSans(
                              fontSize: 17, color: colors.headingTextColor.withOpacity(0.8)),
                        ),
                        const SizedBox(height: 1,),
                        Text(
                          model.date,
                          style: GoogleFonts.nunitoSans(
                              fontSize: 17, color: colors.headingTextColor.withOpacity(0.8)),
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
                          model.rsvp ? 'RSVP\'d' : 'RSVP',
                          style: GoogleFonts.nunitoSans(
                              color: model.rsvp
                                  ? colors.accentColor
                                  : colors.scaffoldColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: colors.accentColor),
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
