import 'dart:collection';
import 'dart:convert';

import 'package:amrita_events_flutter/models/notification.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:amrita_events_flutter/widgets/custom_sliver_widget.dart';
import 'package:amrita_events_flutter/widgets/day_notification_widget.dart';
import 'package:amrita_events_flutter/widgets/top_bar_no_search_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/http_modules.dart';
import 'notification_skeleton_widget.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => NotificationsState();
}

class NotificationsState extends State<Notifications>
    with AutomaticKeepAliveClientMixin {
  Map<String, List<NotificationModel>> mapData = {};
  List<Widget> notificationList = [];

  _getData() async {
    mapData.clear();

    setState(() {
      isLoading = true;
    });

    var response = await makePostRequest(
        null, "/notification/getNotifications", null, true, context);

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body)["data"]; //List Data
      for (var i in responseData) {
        var data = NotificationModel.fromJSON(i);
        addMapData(data);
      }

      setState(() {
        isLoading = true;
      });

      //TODO: Explore this data structure, I mean come on who knew maps could be sorted
      buildList();
    }
  }

  addMapData(model) {
    var dateString = model.date.toString().split(" ")[0];
    var mapItem = mapData[dateString];
    if (mapItem != null) {
      mapData[dateString]!.add(model);
    } else {
      mapData[dateString] = [];
      mapData[dateString]!.add(model);
    }
    setState(() {});
  }

  buildList() {
    notificationList.clear();
    SplayTreeMap<String, dynamic>.from(mapData, (a, b) => b.compareTo(a))
        .forEach((key, value) {
      notificationList.add(DayNotificationWidget(
        model: value,
        date: key,
      ));
    });
    setState(() {});
  }

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.scaffoldColor,
      body: RefreshIndicator(
        onRefresh: () async {
          await _getData();
        },
        child: CustomSliverView(columnList: [
          const TopBarWidgetNoSearch(
              icon: Icons.notifications_none_outlined, title: "Notifications"),
          notificationList.isNotEmpty
              ? Column(
                  children: notificationList,
                )
              : !isLoading
                  ? const NoNotificationsWidget()
                  : Column(
                      children: const [
                        NotificationSkeletonWidget(),
                        NotificationSkeletonWidget(),
                        NotificationSkeletonWidget(),
                        NotificationSkeletonWidget(),
                      ],
                    ),
        ]),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class YesNotificationsWidget extends StatefulWidget {
  const YesNotificationsWidget({Key? key, required this.notificationList})
      : super(key: key);
  final List<Widget> notificationList;

  @override
  State<YesNotificationsWidget> createState() => _YesNotificationsWidgetState();
}

class _YesNotificationsWidgetState extends State<YesNotificationsWidget> {
  @override
  void didUpdateWidget(covariant YesNotificationsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.notificationList,
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
          height: MediaQuery.of(context).size.width * 0.9,
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
