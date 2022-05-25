import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:amrita_events_flutter/widgets/custom_sliver_widget.dart';
import 'package:amrita_events_flutter/widgets/day_notification_widget.dart';
import 'package:amrita_events_flutter/widgets/top_bar_no_search_widget.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.scaffoldColor,
      body: const CustomSliverView(
        columnList: [
          TopBarWidgetNoSearch(
              icon: Icons.notifications_none_outlined, title: "Notifications"),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: DayNotificationWidget(),
          )
        ],
      ),
    );
  }
}
