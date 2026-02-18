import 'package:evently/Core/Caching/Shared%20Prefrences/shared_pref.dart';
import 'package:evently/Core/Models/event_model.dart';
import 'package:evently/Core/Caching/Hive/hive_helper.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../../Core/Firebase/firebase_manager.dart';

abstract class FaveTabDS {
  Future<List<EventModel>> getFavEvents();
}

@Named("remote")
@Injectable(as: FaveTabDS)
class FaveTabRemoteDSImp extends FaveTabDS {
  @override
  Future<List<EventModel>> getFavEvents() async {
    final user = PreferencesHelper.getActiveUser();
    if (user == null) return [];

    final snapshot = await FirebaseManager.eventsCollection()
        .where("userId", isEqualTo: user)
        .where("isFav", isEqualTo: true)
        .get();

    var result= snapshot.docs.map((doc) => doc.data()).toList();
    HiveHelper.cacheFavEvents(result);
    return result;
  }
}

@Named("local")
@Injectable(as: FaveTabDS)
class FaveTabLocalDSImp extends FaveTabDS {
  @override
  Future<List<EventModel>> getFavEvents() async {
    final cachedEvents = await HiveHelper.getCachedFavEvents();
    return cachedEvents.where((e) => e.isFav).toList();
  }
}
