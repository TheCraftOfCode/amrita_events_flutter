import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:amrita_events_flutter/utils/constants.dart' as constants;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopBarWidgetNoSearch extends StatelessWidget {
  const TopBarWidgetNoSearch(
      {Key? key, required this.icon, required this.title})
      : super(key: key);

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
          shape: constants.rightBeveledRectangle, color: colors.cardColor),
      height: MediaQuery.of(context).size.height * 0.30,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Container(),
              flex: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Row(
                    children: [
                      Icon(
                        icon,
                        size: 40,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      AutoSizeText(
                        title,
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.normal,
                            color: colors.primaryTextColor,
                            fontSize: 35),
                        maxLines: 2,
                        minFontSize: 28,
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
