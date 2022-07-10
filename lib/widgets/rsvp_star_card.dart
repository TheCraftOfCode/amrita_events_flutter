import 'dart:convert';
import 'package:amrita_events_flutter/models/rsvp_model.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'network_image.dart';

class RSVPStarCard extends StatelessWidget {
  const RSVPStarCard(
      {Key? key, required this.model, required this.index, required this.onTap})
      : super(key: key);

  final EventRSVPModel model;
  final VoidCallback onTap;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 10,
        color: colors.cardBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(
                  height: 250,
                  width: double.maxFinite,
                  child: networkImage(model.posterUrl),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "RSVP: ${model.countOfRSVP}",
                          style: GoogleFonts.nunitoSans(
                              fontSize: 20, color: colors.headingTextColor),
                        ),
                        Text(
                          "Viewed: ${model.countOfEventViewed}",
                          style: GoogleFonts.nunitoSans(
                              fontSize: 20, color: colors.headingTextColor),
                        ),
                      ],
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
