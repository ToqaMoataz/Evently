import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive_flutter/adapters.dart';

part 'event_model.g.dart';

@HiveType(typeId: 0)
class EventModel extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String eventCategory;
  @HiveField(2)
  String title;
  @HiveField(3)
  String description;
  @HiveField(4)
  int date;
  @HiveField(5)
  String time;
  @HiveField(6)
  String location;
  @HiveField(7)
  bool isFav;
  @HiveField(8)
  bool toBeNotified;
  @HiveField(9)
  String userId;
  @HiveField(10)
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

    DateTime baseDate = DateTime.fromMillisecondsSinceEpoch(date);

    final parts = time.split(RegExp(r'[: ]'));
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);
    final period = parts.length > 2 ? parts[2].toUpperCase() : '';

    if (period == 'PM' && hour < 12) {
      hour += 12;
    } else if (period == 'AM' && hour == 12) {
      hour = 0;
    }
    return DateTime(baseDate.year, baseDate.month, baseDate.day, hour, minute);
  }

}
