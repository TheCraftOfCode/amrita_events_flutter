import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class SettingCard extends StatelessWidget {
  SettingCard({
    Key? key,
    required this.icon,
    required this.title,required this.onTap,
  }) : super(key: key);
  final IconData icon;
  final String title;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 20.0, left: 8.0, right: 8.0, bottom: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 0,
          color: colors.scaffoldColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  icon,
                  size: 24,
                  color: colors.headingTextColor,
                ),
                const SizedBox(
                  width: 40,
                ),
                Text(
                  title,
                  style: GoogleFonts.nunitoSans(
                      fontSize: 18, color: colors.headingTextColor),
                ),
                const Spacer(
                  flex: 2,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
