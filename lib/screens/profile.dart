import 'package:amrita_events_flutter/widgets/custom_sliver_widget.dart';
import 'package:amrita_events_flutter/widgets/top_bar_no_search_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;

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
          TopBarWidgetNoSearch(icon: Icons.person_outline, title: "Profile")
        ],
      ),
    );
  }
}
