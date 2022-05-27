import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:amrita_events_flutter/widgets/custom_sliver_widget.dart';
import 'package:amrita_events_flutter/widgets/day_notification_widget.dart';
import 'package:amrita_events_flutter/widgets/top_bar_no_search_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key, required this.yesNotifications})
      : super(key: key);

  final bool yesNotifications;

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.scaffoldColor,
      body: CustomSliverView(columnList: [
        const TopBarWidgetNoSearch(
            icon: Icons.notifications_none_outlined, title: "Notifications"),
        widget.yesNotifications
            ? const YesNotificationsWidget()
            : const NoNotificationsWidget(),
      ]),
    );
  }
}

class YesNotificationsWidget extends StatelessWidget {
  const YesNotificationsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: DayNotificationWidget(),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: DayNotificationWidget(),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: DayNotificationWidget(),
        )
      ],
    );
  }
}

class NoNotificationsWidget extends StatelessWidget {
  const NoNotificationsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image(
          image: const AssetImage('assets/empty_notifications.png'),
          height: MediaQuery.of(context).size.width*0.9,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
              child: Text(
            'Well, looks like there’s nothing happening. We\'ll send alerts when something does :)',
            textAlign: TextAlign.center,
            style: GoogleFonts.nunitoSans(
                fontSize: 25,
                fontWeight: FontWeight.normal,
                color: colors.headingTextColor),
          )),
        ),
      ],
    );
  }
}
