import 'package:google_maps_flutter/google_maps_flutter.dart';

class EventModel {
  String id;
  String eventCategory;
  String title;
  String description;
  int date;
  String time;
  String location;
  bool isFav;
  bool toBeNotified;
  String userId;
  LatLng eventPosition;

  EventModel({
    this.id = '',
    required this.eventCategory,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.location,
    this.isFav = false,
    this.toBeNotified=true,
    required this.userId,
    required this.eventPosition,
  });

  factory EventModel.fromJson(Map<String, dynamic> json, String docId) {
    return EventModel(
      id: docId,
      eventCategory: json['eventCategory'],
      title: json['title'],
      description: json['description'],
      date: json['date'],
      time: json['time'],
      location: json['location'],
      isFav: json['isFav'] ?? false,
      toBeNotified: json['toBeNotified'] ?? true,
      userId: json['userId'],
      eventPosition: LatLng(
        (json['eventPosition']['latitude'] as num).toDouble(),
        (json['eventPosition']['longitude'] as num).toDouble(),
      ),
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
      'toBeNotified':toBeNotified,
      'userId': userId,
      'eventPosition': {
        'latitude': eventPosition.latitude,
        'longitude': eventPosition.longitude,
      },
    };
  }

  DateTime get dateTime {
    final year = date ~/ 10000;
    final month = (date % 10000) ~/ 100;
    final day = date % 100;

    final parts = time.split(RegExp(r'[: ]'));
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);
    final period = parts.length > 2 ? parts[2].toUpperCase() : '';

    if (period == 'PM' && hour < 12) {
      hour += 12;
    } else if (period == 'AM' && hour == 12) {
      hour = 0;
    }

    return DateTime(year, month, day, hour, minute);
  }

}
