import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({Key? key, required this.title, required this.body})
      : super(key: key);

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              title,
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: colors.headingTextColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              body,
              style: GoogleFonts.nunitoSans(
                  color: colors.headingTextColor,
                  fontSize: 18,
                  fontWeight: FontWeight.normal),
            ),
          ),
          Divider(
            color: colors.headingTextColor,
            thickness: 0.5,
          )
        ],
      ),
    );
  }
}
