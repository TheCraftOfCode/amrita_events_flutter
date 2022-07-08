import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:google_fonts/google_fonts.dart';

class AdminCard extends StatelessWidget {
  const AdminCard(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.iconData, required this.onTap})
      : super(key: key);
  final String title;
  final String subTitle;
  final IconData iconData;
  final VoidCallback onTap;

  // final String icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 10,
        color: colors.cardBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: InkWell(
            onTap: onTap,
            child: Row(
              children: [
                Expanded(
                    child: Icon(
                  iconData,
                  size: 45,
                  color: Colors.white,
                )),
                Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.nunitoSans(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: colors.headingTextColor),
                        ),
                        Text(
                          subTitle,
                          style: GoogleFonts.nunitoSans(
                              fontSize: 14, color: colors.headingTextColor),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
