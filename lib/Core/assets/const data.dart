import 'package:evently/Core/assets/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum RequestState { init, loading, success, error }

class AppData{

  static const List<String> events = [
    "All",
    "Book Club",
    "Sport",
    "Birthday",
    "Eating",
    "Meeting",
    "Workshop",
    "Holiday",
    "Gaming",
    "Occasions",
    "Exhibition"
  ];

  static const List<String> eventsDisplay = [
    "all_text",
    "book_club_text",
    "sport_text",
    "birthday_text",
    "eating_text",
    "meeting_text",
    "workshop_text",
    "holiday_text",
    "gaming_text",
    "occasions_text",
    "exhibition_text"
  ];


  static const List<IconData> eventIcon = [
    Icons.assistant_navigation,
    Icons.menu_book_outlined,
    Icons.directions_bike_outlined,
    Icons.cake_outlined,
    Icons.restaurant_outlined,
    Icons.groups_outlined,
    Icons.work_outline,
    Icons.beach_access_outlined,
    Icons.sports_esports_outlined,
    Icons.museum_outlined,
  ];
}