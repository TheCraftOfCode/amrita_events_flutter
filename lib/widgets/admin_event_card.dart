import 'package:amrita_events_flutter/screens/event_page.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/event_model.dart';
import '../screens/onboarding.dart';
import 'network_image.dart';

class AdminStarCard extends StatelessWidget {
  const AdminStarCard({Key? key, required this.model}):super(key: key);

  final EventModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //TODO: Navigate to edit event page
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
