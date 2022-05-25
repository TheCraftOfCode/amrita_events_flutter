import 'package:amrita_events_flutter/widgets/custom_sliver_widget.dart';
import 'package:amrita_events_flutter/widgets/starred_card.dart';
import 'package:amrita_events_flutter/widgets/top_bar_widget.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;

import '../onboarding.dart';

class Starred extends StatefulWidget {
  const Starred({Key? key}) : super(key: key);

  @override
  State<Starred> createState() => _StarredState();
}

class _StarredState extends State<Starred> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.scaffoldColor,
      body: CustomSliverView(
        columnList: [
          TopBarWidget(icon: Icons.star_border_sharp, title: "Starred"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:  StarCard(event_name: "event_name", time: "time", date: "date")
          ) ,
          Padding(
              padding: const EdgeInsets.all(8.0),
              child:  StarCard(event_name: "event_name", time: "time", date: "date")
          ) ],
      ),
    );
  }
}
