import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:amrita_events_flutter/utils/constants.dart' as constants;
import 'package:amrita_events_flutter/widgets/textbox_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopBarWidget extends StatelessWidget {
  const TopBarWidget({Key? key, required this.icon, required this.title})
      : super(key: key);

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
          shape: constants.rightBeveledRectangle, color: colors.cardColor),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: 40,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: GoogleFonts.nunitoSans(
                      fontSize: 45,
                      fontWeight: FontWeight.normal,
                      color: colors.primaryTextColor),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: TextBoxField(
                        hint: 'Type to search',
                        light: true,
                        validator: (val) {},
                        padding: const EdgeInsets.all(0.0),
                        title: 'Search',
                      ),
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: () {},
                    backgroundColor: colors.scaffoldColor,
                    child: Icon(
                      Icons.search_outlined,
                      color: colors.headingTextColor,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
