import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:amrita_events_flutter/widgets/custom_sliver_widget.dart';
import 'package:amrita_events_flutter/widgets/starred_card.dart';
import 'package:amrita_events_flutter/widgets/top_bar_widget.dart';
import 'package:flutter/material.dart';

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
      body: const CustomSliverView(
        columnList: [
          TopBarWidget(icon: Icons.star_border_sharp, title: "Starred"),
          Padding(
              padding: EdgeInsets.all(8.0),
              child: StarCard(
                  eventName: "event_name", time: "time", date: "date")),
          Padding(
              padding: EdgeInsets.all(8.0),
              child:
                  StarCard(eventName: "event_name", time: "time", date: "date"))
        ],
      ),
    );
  }
}
