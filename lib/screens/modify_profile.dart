import 'package:amrita_events_flutter/widgets/top_bar_widget_with_text.dart';
import 'package:flutter/material.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:amrita_events_flutter/utils/constants.dart' as constants;
import 'package:google_fonts/google_fonts.dart';

import '../onboarding.dart';
import '../widgets/custom_sliver_widget.dart';
import '../widgets/textbox_widget.dart';


class ModifyProfile extends StatefulWidget {
  const ModifyProfile({Key? key}) : super(key: key);

  @override
  State<ModifyProfile> createState() => _ModifyProfileState();
}

class _ModifyProfileState extends State<ModifyProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.scaffoldColor,
      body: CustomSliverView(
        columnList: [
          TopBarWithTextWidget(title: 'Modify Profile', text: 'Want to change your detals? We got your back!'),
Padding(
  padding: const EdgeInsets.fromLTRB(10, 30, 10, 30),
  child:   Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Container(
        color: colors.headingTextColor,
        height: 150,
  width: 200,
      ),

      Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: ElevatedButton.icon(

                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FeaturesPage()));
                },
                label: Text(
                  'CHANGE',
                  style: GoogleFonts.nunitoSans(
                      fontSize: 12,
                      color: colors.scaffoldColor,
                      fontWeight: FontWeight.bold),
                ),
                style:

                ElevatedButton.styleFrom(primary: colors.headingTextColor),
                icon: Icon(Icons.change_circle, color: colors.scaffoldColor,),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: ElevatedButton.icon(

                onPressed: () {

                },
                label: Text(
                  'REMOVE',
                  style: GoogleFonts.nunitoSans(
                      fontSize: 12,
                      color: colors.scaffoldColor,
                      fontWeight: FontWeight.bold),
                ),
                style:

                ElevatedButton.styleFrom(primary: colors.headingTextColor),
                icon: Icon(Icons.remove, color: colors.scaffoldColor,),
              ),
            ),
          ),
        ],
      )

    ],
  ),
),
          Padding(
            padding:
            const EdgeInsets.only(bottom: 5, top: 20, left: 30, right: 30),
            child: TextBoxField(

              validator: (value) {},
              padding: const EdgeInsets.only(bottom: 5),
              title: 'Phone Number',
              hint: '1234567890',
              light: true,

            ),
          ),
          Padding(
            padding:
            const EdgeInsets.only(bottom: 5, top: 20, left: 30, right: 30),
            child: TextBoxField(

              validator: (value) {},
              padding: const EdgeInsets.only(bottom: 5),
              title: 'E-Mail',
              hint: 'abc@gmail.com',
              light: true,

            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
            child: ElevatedButton.icon(

              onPressed: () {

              },
              label: Text(
                'SAVE',
                style: GoogleFonts.nunitoSans(
                    fontSize: 14,
                    color: colors.scaffoldColor,
                    fontWeight: FontWeight.bold),
              ),
              style:

              ElevatedButton.styleFrom(primary: colors.headingTextColor),
              icon: Icon(Icons.save, color: colors.scaffoldColor,),

            ),
          ),
        ],
      ),
    );
  }
}
