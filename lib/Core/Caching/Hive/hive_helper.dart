import 'package:evently/Core/Models/event_model.dart';
import 'package:evently/Core/Models/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveHelper {
  static const String _eventsBoxName = "eventsBox";
  static const String _favEventsBoxName = "favEventsBox";
  static const String _userBoxName = "userBox";

  static Future<Box<EventModel>> _openEventsBox() async {
    if (!Hive.isBoxOpen(_eventsBoxName)) {
      return Hive.openBox<EventModel>(_eventsBoxName);
    }
    return Hive.box<EventModel>(_eventsBoxName);
  }

  static Future<Box<EventModel>> _openFavEventsBox() async {
    if (!Hive.isBoxOpen(_favEventsBoxName)) {
      return Hive.openBox<EventModel>(_favEventsBoxName);
    }
    return Hive.box<EventModel>(_favEventsBoxName);
  }

  static Future<void> cacheEvents(List<EventModel> events) async {
    final box = await _openEventsBox();
    await box.clear();
    await box.addAll(events);
  }

  static Future<List<EventModel>> getCachedEvents() async {
    final box = await _openEventsBox();
    return box.values.toList();
  }

  static Future<void> cacheFavEvents(List<EventModel> events) async {
    final box = await _openFavEventsBox();
    await box.clear();
    await box.addAll(events);
  }

  static Future<List<EventModel>> getCachedFavEvents() async {
    final box = await _openFavEventsBox();
    return box.values.toList();
  }

  static Future<void> toggleEvent(String eventId) async {
    final box = await _openEventsBox();
    EventModel? storedEvent;
    for (var e in box.values) {
      if (e.id == eventId) {
        storedEvent = e;
        break;
      }
    }
    if (storedEvent != null) {
      storedEvent.isFav = !storedEvent.isFav;
      await storedEvent.save();
    }
  }

  static Future<void> deleteEvents() async {
    final box = await _openEventsBox();
    await box.clear();
  }

  static Future<Box<UserModel>> _openUserBox() async {
    if (!Hive.isBoxOpen(_userBoxName)) {
      return Hive.openBox<UserModel>(_userBoxName);
    }
    return Hive.box<UserModel>(_userBoxName);
  }

  static Future<void> storeUser(UserModel user) async {
    final box = await _openUserBox();
    await box.clear();
    await box.add(user);
  }

  static Future<UserModel?> getStoredUser() async {
    final box = await _openUserBox();
    if (box.isEmpty) return null;
    return box.values.first;
  }

  static Future<void> deleteUser() async {
    final box = await _openUserBox();
    await box.clear();
  }
}
