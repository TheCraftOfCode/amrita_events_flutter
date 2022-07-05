class EventModel {
  final String id;
  final String title;
  final String date;
  final String time;
  final String location;
  final String description;
  final bool eventOver;
  final String eventType;

  EventModel({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.description,
    required this.eventOver,
    required this.eventType,
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
        eventType: decodedData['eventType']);
  }
}
