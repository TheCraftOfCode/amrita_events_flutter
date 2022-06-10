import 'package:amrita_events_flutter/screens/about_page.dart';
import 'package:amrita_events_flutter/screens/modify_profile.dart';
import 'package:amrita_events_flutter/screens/request_features_page.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:amrita_events_flutter/widgets/custom_sliver_widget.dart';
import 'package:amrita_events_flutter/widgets/settings_card.dart';
import 'package:amrita_events_flutter/widgets/top_bar_no_search_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.scaffoldColor,
      body: CustomSliverView(
        columnList: [
          const TopBarWidgetNoSearch(
              icon: Icons.settings_outlined, title: "Settings"),
          SettingCard(
            icon: Icons.edit,
            title: "Modify Profile",
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ModifyProfile()));
            },
          ),
          SettingCard(
            icon: Icons.insert_invitation_outlined,
            title: "Invite",
            onTap: () {},
          ),
          SettingCard(
            icon: Icons.info,
            title: "About",
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AboutPage()));
            },
          ),
          SettingCard(
            icon: Icons.laptop,
            title: "Contribute",
            onTap: () {},
          ),
          SettingCard(
            icon: Icons.request_page_outlined,
            title: "Request a feature",
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RequestFeaturesPage()));
            },
          ),
          SettingCard(
            icon: Icons.bug_report_outlined,
            title: "Report a bug",
            onTap: () {},
          ),
          SettingCard(
            icon: Icons.checklist_rtl_outlined,
            title: "License",
            onTap: () {},
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 25.0, 8.0, 25.0),
            child: Text(
              "VERSION 1.0.0",
              style: GoogleFonts.nunitoSans(
                  fontSize: 14, color: colors.headingTextColor),
            ),
          )
        ],
      ),
    );
  }
}
