class NotificationModel {
  final String title;
  final String body;
  final DateTime date;

  NotificationModel(
      {required this.date, required this.title, required this.body});

  static NotificationModel fromJSON(decodedData) {
    return NotificationModel(
        date: DateTime.parse(decodedData['date']),
        title: decodedData['title'],
        body: decodedData['body']);
  }
}
