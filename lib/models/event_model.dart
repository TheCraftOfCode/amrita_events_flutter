class EventModel {
  final String id;
  final String title;
  final String date;
  final String dateUnparsed;
  final String time;
  final String location;
  final String description;
  final bool eventOver;
  bool rsvp;
  final String eventType;

  EventModel({
    required this.id,
    required this.title,
    required this.date,
    required this.dateUnparsed,
    required this.time,
    required this.location,
    required this.description,
    required this.eventOver,
    required this.rsvp,
    required this.eventType,
  });

  static EventModel fromJSON(decodedData) {
    print(decodedData);
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
        dateUnparsed: decodedData['dateUnparsed']);
  }
}
