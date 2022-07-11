import 'package:amrita_events_flutter/models/user_model.dart';

class EventRSVPModel {
  final String id;
  final String title;
  final String date;
  final String time;
  final String location;
  final String posterUrl;
  final String host;
  final int countOfRSVP;
  final int countOfEventViewed;
  final String description;
  final bool eventOver;
  final String eventType;
  final List<User> rsvpUsers;

  EventRSVPModel(
      {required this.id,
      required this.title,
      required this.date,
      required this.time,
      required this.posterUrl,
      required this.host,
      required this.location,
      required this.description,
      required this.eventOver,
      required this.eventType,
      required this.countOfRSVP,
      required this.countOfEventViewed,
      required this.rsvpUsers});

  static EventRSVPModel fromJSON(decodedData) {
    List users = decodedData['listOfRSVPUsers'];

    return EventRSVPModel(
      id: decodedData['_id'],
      title: decodedData['eventName'],
      date: decodedData['date'],
      time: decodedData['time'],
      location: decodedData['location'],
      description: decodedData['description'],
      eventOver: decodedData['eventOver'],
      eventType: decodedData['eventType'],
      posterUrl: decodedData['posterUrl'] ?? '',
      host: decodedData['host'],
      rsvpUsers: users.map((e) => User.fromJSON(e)).toList(),
      countOfRSVP: decodedData['countOfRSVP'],
      countOfEventViewed: decodedData['countOfEventViewed'],
    );
  }
}
