
import 'package:flutter/material.dart';

import '../models/event_model.dart';

class YesStarredEventsWidget extends StatefulWidget {
  const YesStarredEventsWidget({Key? key}) : super(key: key);

  @override
  State<YesStarredEventsWidget> createState() => YesStarredEventsWidgetState();
}

class YesStarredEventsWidgetState extends State<YesStarredEventsWidget> {
  List<EventModel> data = [];
  List<EventModel> dataSearch = [];


  addData(List<EventModel> data) {
    data.clear();
    dataSearch.clear();
    for (var i in data) {
      if (i.starred) {
        data.add(i);
        dataSearch.add(i);
        print("Added " + i.toString());
      }
    }
  }

  @override
  void initState() {
    super.initState();
    print("INIT");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        // StarCard(eventName: "event_name", time: "time", date: "date"),
        // StarCard(eventName: "event_name", time: "time", date: "date")
      ],
    );
  }
}