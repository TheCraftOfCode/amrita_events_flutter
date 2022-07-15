import 'package:amrita_events_flutter/utils/data.dart';
import 'package:flutter/material.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

Widget contactCard(PeopleData data) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: colors.cardBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(data.pictureURL,
                  width: 90,
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 13),
                    child: Text(data.name,
                        style: GoogleFonts.nunito(
                            fontSize: 17,
                            color: colors.primaryTextColor,
                            fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, left: 13),
                    child: Text(data.rollNo ?? "",
                        style: GoogleFonts.nunito(
                            fontSize: 17,
                            color: colors.primaryTextColor.withOpacity(0.7))),
                  ),
                  Row(
                    children: [
                      IconButton(
                          icon: const FaIcon(FontAwesomeIcons.instagram),
                          iconSize: 20,
                          splashRadius: 20,
                          color: Colors.pink,
                          onPressed: () async {
                            await launch(data.instagram ?? "");
                          }),
                      IconButton(
                          icon: const FaIcon(FontAwesomeIcons.google),
                          iconSize: 18,
                          splashRadius: 20,
                          color: const Color.fromARGB(196, 255, 83, 40),
                          onPressed: () async {
                            await launch("mailto:${data.mail}");
                          }),
                      IconButton(
                          icon: const FaIcon(FontAwesomeIcons.phone),
                          iconSize: 17,
                          splashRadius: 20,
                          color: Colors.blueAccent,
                          onPressed: () async {
                            await launch("tel://+91${data.phoneNo}");
                          })
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// onPressed: () async {
// await launch("tel://+91${data.phoneNo}");
// },
