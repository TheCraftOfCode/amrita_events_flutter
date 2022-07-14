import 'package:amrita_events_flutter/screens/change_password.dart';
import 'package:amrita_events_flutter/screens/greeting_page.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:amrita_events_flutter/widgets/custom_sliver_widget.dart';
import 'package:amrita_events_flutter/widgets/profile_card.dart';
import 'package:amrita_events_flutter/widgets/top_bar_no_search_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/utils.dart';
import '../widgets/alert_dialog.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.scaffoldColor,
      body: CustomSliverView(
        columnList: [
          const TopBarWidgetNoSearch(
              icon: Icons.person_outline, title: "Profile"),
          //
          Expanded(
            child: Container(),
            flex: 2,
          ),
          const ProfileCard(),
          Expanded(
            child: Container(),
            flex: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: ElevatedButton(
                      onPressed: () {
                        displayDialog(context, "Yes", "No", () {
                          clearAllData();
                          // showToast("Signed out successfully!");
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const GreetingPage()),
                              (Route<dynamic> route) => false);
                        }, "Are you sure you want to sign out?",
                            "You will be signed out and all data will be lost");
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 10.0),
                        child: Text(
                          "SIGN OUT",
                          style: GoogleFonts.raleway(
                              fontSize: 10,
                              color: colors.primaryTextColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: colors.headingTextColor),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return const ChangePassword();
                          }));
                        },
                        style: ElevatedButton.styleFrom(
                            primary: colors.headingTextColor),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 10.0),
                          child: Text(
                            "CHANGE PASSWORD",
                            style: GoogleFonts.raleway(
                                fontSize: 10,
                                color: colors.primaryTextColor,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(),
            flex: 2,
          ),
        ],
      ),
    );
  }
}

//TODO: Has to be finished
