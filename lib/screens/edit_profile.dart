import 'package:amrita_events_flutter/screens/profile.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import "package:amrita_events_flutter/utils/constants.dart";
import 'package:amrita_events_flutter/widgets/alert_dialog.dart';
import 'package:amrita_events_flutter/widgets/custom_sliver_widget.dart';
import 'package:amrita_events_flutter/widgets/textbox_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/profile_widget.dart';
import '../widgets/top_bar_no_search_widget.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.scaffoldColor,
      body: CustomSliverView(
        columnList: [
          const TopBarWidgetNoSearch(icon: Icons.edit, title: "Edit Profile"),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: ProfileWidget(
              imagePath:
                  "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/22/22a4f44d8c8f1451f0eaa765e80b698bab8dd826_full.jpg",
              isEdit: true,
              onClicked: () async {},
            ),
          ),
          TextBoxField(
              title: "Name",
              hint: "Sumithra",
              padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
              light: false),
          TextBoxField(
              title: "Roll Number",
              hint: "CB.EN.U4CSE19247",
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              light: false),
          TextBoxField(
              title: "E-Mail",
              hint: "sums@gmail.com",
              padding: EdgeInsets.fromLTRB(20, 60, 20, 20),
              light: false),
          TextBoxField(
              title: "GitHub",
              hint: "Sumithra1306",
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              light: false),
          TextBoxField(
              title: "Phone Number",
              hint: "1234561306",
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              light: false),
          TextBoxField(
              title: "Instagram",
              hint: "Sumithra1306",
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              light: false),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.65,
              child: ElevatedButton(
                onPressed: () {
                  displayDialog(context, "Yes", "No", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Profile()),
                    );
                  }, "Save Changes",
                      "Are you sure you want to save the changes?");
                  //     MaterialPageRoute(builder: (context) => OTPScreen()));
                },
                child: Text(
                  'SAVE',
                  style: GoogleFonts.nunitoSans(
                      color: colors.primaryTextColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(primary: colors.accentColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}
