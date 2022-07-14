import 'package:amrita_events_flutter/models/notification.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:amrita_events_flutter/widgets/notification_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DayNotificationWidget extends StatefulWidget {
  const DayNotificationWidget(
      {Key? key, required this.date, required this.model})
      : super(key: key);

  final String date;
  final List<NotificationModel> model;

  @override
  State<DayNotificationWidget> createState() => _DayNotificationWidgetState();
}

class _DayNotificationWidgetState extends State<DayNotificationWidget> {
  List<Widget> list = [];

  buildList() {
    list.add(
      Padding(
        padding: const EdgeInsets.only(top: 30, bottom: 20, left: 20),
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            widget.date,
            style: GoogleFonts.nunitoSans(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: colors.accentColor),
          ),
        ),
      ),
    );
    list = list +
        widget.model
            .map((e) => NotificationWidget(title: e.title, body: e.body))
            .toList().reversed.toList();
  }

  @override
  void initState() {
    super.initState();
    buildList();
  }

  @override
  void didUpdateWidget(covariant DayNotificationWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    list.clear();
    buildList();
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: list),
    );
  }
}
