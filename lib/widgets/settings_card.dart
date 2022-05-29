import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:amrita_events_flutter/utils/constants.dart' as constants;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingCard extends StatelessWidget {
  const SettingCard({Key? key, required this.icon, required this.title,  }) : super(key: key);
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: (){

        },
        child: Card(
          elevation: 10,
          color: colors.cardBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(icon, size: 24, color: colors.headingTextColor,),
                 SizedBox(width: 40,),
                Text(title, style: GoogleFonts.nunitoSans(
                  fontSize: 18,
                  color: colors.headingTextColor
                ),),
                Spacer(flex: 2,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

