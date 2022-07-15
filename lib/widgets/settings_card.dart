import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingCard extends StatelessWidget {
  const SettingCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);
  final IconData icon;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0, bottom: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 10,
          color: colors.cardBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(width: 20,),
                Icon(
                  icon,
                  size: 24,
                  color: colors.headingTextColor,
                ),
                const SizedBox(
                  width: 30,
                ),
                Text(
                  title,
                  style: GoogleFonts.raleway(
                      fontSize: 20, color: colors.headingTextColor),
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
