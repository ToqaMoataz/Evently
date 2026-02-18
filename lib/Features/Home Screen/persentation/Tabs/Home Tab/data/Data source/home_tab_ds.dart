import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/Core/Caching/Hive/hive_helper.dart';
import 'package:evently/Core/Caching/Shared%20Prefrences/shared_pref.dart';
import 'package:evently/Core/Models/event_model.dart';
import 'package:evently/Core/assets/const%20data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../Core/Firebase/firebase_manager.dart';

abstract class HomeTabDS {
  Future<List<EventModel>> getUserEvents(String category);

  Future<List<EventModel>> filterEvents(String category, String userId);
}

@Named("remote")
@Injectable(as: HomeTabDS)
class HomeTabRemoteDSImp extends HomeTabDS {
  @override
  Future<List<EventModel>> getUserEvents(String category) async {
    final userId = PreferencesHelper.getActiveUser();
    if (userId == null) return [];
    List<EventModel> events;
    if (category == AppData.events[0]) {
      Query<EventModel> query = FirebaseManager.eventsCollection().where(
        "userId",
        isEqualTo: userId,
      );
      final snapshot = await query.get();
      events = snapshot.docs.map((doc) => doc.data()).toList();
    } else {
      events = await filterEvents(category, userId);
    }
    await HiveHelper.cacheEvents(events);
    return events;
  }

  @override
  Future<List<EventModel>> filterEvents(String category, String userId) async {
    final snapshot =
        await FirebaseManager.eventsCollection()
            .where("userId", isEqualTo: userId)
            .where('eventCategory', isEqualTo: category)
            .get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}

@Named("local")
@Injectable(as: HomeTabDS)
class HomeTabLocalDSImp extends HomeTabDS {
  @override
  Future<List<EventModel>> getUserEvents(String category) async {
    final cachedEvents = await HiveHelper.getCachedEvents();
    return cachedEvents;
  }

  @override
  Future<List<EventModel>> filterEvents(String category, String userId) async {
    final cachedEvents = await HiveHelper.getCachedEvents();
    return cachedEvents.where((e) => e.eventCategory == category).toList();
  }
}
