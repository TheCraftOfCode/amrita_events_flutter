import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:amrita_events_flutter/widgets/notification_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DayNotificationWidget extends StatelessWidget {
  const DayNotificationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 20),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                '18 May 2022',
                style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: colors.notificationDateColors),
              ),
            ),
          ),
          const NotificationWidget(
              title: 'Notification title',
              body:
                  'This is some nice notification content. Amazing, no? I knoww. Looks really nice. I’m awesome!'),
          const NotificationWidget(
              title: 'Notification title',
              body:
                  'This is some nice notification content. Amazing, no? I knoww. Looks really nice. I’m awesome!'),
          const NotificationWidget(
              title: 'Notification title',
              body:
                  'This is some nice notification content. Amazing, no? I knoww. Looks really nice. I’m awesome!'),
        ],
      ),
    );
  }
}
