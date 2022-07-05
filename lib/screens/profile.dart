import 'package:amrita_events_flutter/screens/greeting_page.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:amrita_events_flutter/widgets/custom_sliver_widget.dart';
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

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    color: colors.headingTextColor,
                    height: 100,
                    width: 100,
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Column(
                    children: [
                      Text(
                        "Username",
                        style: GoogleFonts.nunitoSans(
                          color: colors.headingTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 100,
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.edit,
                            size: 20,
                            color: colors.headingTextColor,
                          )),
                      SizedBox(
                        height: 100,
                      ),
                    ],
                  )
                ]),
          ),
          ElevatedButton(
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
              child: Text("Sign Out"))
        ],
      ),
    );
  }
}

//TODO: Has to be finished
