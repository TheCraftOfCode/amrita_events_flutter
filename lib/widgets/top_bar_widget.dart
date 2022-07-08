import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:amrita_events_flutter/utils/constants.dart' as constants;
import 'package:amrita_events_flutter/widgets/textbox_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopBarWidget extends StatelessWidget {
  const TopBarWidget({Key? key, required this.icon, required this.title, this.onChanged})
      : super(key: key);

  final IconData icon;
  final String title;
  final void Function(String?)? onChanged;


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
          shape: constants.rightBeveledRectangle, color: colors.cardColor),
      child: Padding(
        //changed from bottom: 70 to 30
        padding:
            const EdgeInsets.only(left: 30, right: 30, bottom: 30),
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
                  style: GoogleFonts.raleway(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: colors.primaryTextColor),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
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
                        onChanged: onChanged,
                        padding: const EdgeInsets.all(0.0),
                        title: 'Search',
                      ),
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: () {},
                    heroTag: title,
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
