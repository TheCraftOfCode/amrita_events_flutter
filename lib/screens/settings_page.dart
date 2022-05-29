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
          TopBarWidgetNoSearch(icon: Icons.settings_outlined, title: "Settings"),
          SettingCard(icon: Icons.notifications_none, title: "Notification and reminders"),
          SettingCard(icon: Icons.insert_invitation_outlined, title:"Invite"),
          SettingCard(icon: Icons.info, title: "About"),

          SettingCard(icon: Icons.laptop, title: "Contribute"),
          SettingCard(icon: Icons.request_page_outlined, title: "Request a feature"),
          SettingCard(icon: Icons.bug_report_outlined, title: "Report a bug"),
          SettingCard(icon: Icons.checklist_rtl_outlined, title: "Liscence"),

          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 14.0, 8.0, 8.0),
            child: Text("APP VERSION 1.1.0", style: GoogleFonts.nunitoSans(
              fontSize: 18,
              color: colors.headingTextColor
            ),),
          )

        ],
      ),
    );
  }
}
