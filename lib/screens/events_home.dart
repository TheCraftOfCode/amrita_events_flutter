import 'package:amrita_events_flutter/utils/colors.dart' as colors;
import 'package:amrita_events_flutter/widgets/custom_sliver_widget.dart';
import 'package:amrita_events_flutter/widgets/event_card_large_widget.dart';
import 'package:amrita_events_flutter/widgets/starred_card.dart';
import 'package:amrita_events_flutter/widgets/top_bar_widget.dart';
import 'package:flutter/material.dart';

class EventsHome extends StatefulWidget {
  @override
  _EventsHomeState createState() => _EventsHomeState();
}

class Event {
  final String title;
  final String date;
  final String time;

  Event({required this.title, required this.date, required this.time});
}

class _EventsHomeState extends State<EventsHome> {
  List<Event> data = [
    Event(title: 'Event 1', date: '19-05-2022', time: '5:00 PM - 6:00 PM'),
    Event(title: 'Event 2', date: '19-05-2022', time: '5:00 PM - 6:00 PM'),
    Event(title: 'Event 3', date: '19-05-2022', time: '5:00 PM - 6:00 PM'),
    Event(title: 'Event 4', date: '19-05-2022', time: '5:00 PM - 6:00 PM'),
    Event(title: 'Event 5', date: '19-05-2022', time: '5:00 PM - 6:00 PM'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.scaffoldColor,
      body: CustomSliverView(
        columnList: [
          const TopBarWidget(
            icon: Icons.home_outlined,
            title: 'Home',
          ),
          StarCard(date: 'title', time: 'time', eventName: 'title',),
          StarCard(date: 'title', time: 'time', eventName: 'title',),
          StarCard(date: 'title', time: 'time', eventName: 'title',),
          StarCard(date: 'title', time: 'time', eventName: 'title',),
          StarCard(date: 'title', time: 'time', eventName: 'title',),
        ],
      ),
    );
  }
}
