class EventModel {
  final String id;
  final String title;
  final String date;
  final String dateUnparsed;
  final String time;
  final String location;
  final String posterUrl;
  final String host;
  final String description;
  final bool eventOver;
  bool rsvp;
  final String eventType;
  bool starred;

  EventModel({
    required this.id,
    required this.title,
    required this.date,
    required this.dateUnparsed,
    required this.time,
    required this.posterUrl,
    required this.host,
    required this.location,
    required this.description,
    required this.eventOver,
    required this.rsvp,
    required this.eventType,
    required this.starred,
  });

  static EventModel fromJSON(decodedData) {
    return EventModel(
        id: decodedData['_id'],
        title: decodedData['eventName'],
        date: decodedData['date'],
        time: decodedData['time'],
        location: decodedData['location'],
        description: decodedData['description'],
        eventOver: decodedData['eventOver'],
        eventType: decodedData['eventType'],
        rsvp: decodedData['rsvp'],
        dateUnparsed: decodedData['dateUnparsed'],
        posterUrl: decodedData['posterUrl'] ?? '',
        host: decodedData['host'],
        starred: decodedData['starred']);
  }
}
