class EventModel {
  String id;
  String eventCategory;
  String title;
  String description;
  int date;
  String time;
  String location;
  bool isFav;
  String userId;

  EventModel({
    this.id = '', // optional, will be set when saving to Firestore
    required this.eventCategory,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.location,
    this.isFav = false, // default value
    required this.userId, // must be passed in
  });

  factory EventModel.fromJson(
      Map<String, dynamic> json,
      String docId,
      ) {
    return EventModel(
      id: docId,
      eventCategory: json['eventCategory'],
      title: json['title'],
      description: json['description'],
      date: json['date'],
      time: json['time'],
      location: json['location'],
      isFav: json['isFav'] ?? false,
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'eventCategory': eventCategory,
      'title': title,
      'description': description,
      'date': date,
      'time': time,
      'location': location,
      'isFav': isFav,
      'userId': userId,
    };
  }
}
