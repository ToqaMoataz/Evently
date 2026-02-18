import 'package:evently/Core/Caching/Hive/hive_helper.dart';
import 'package:evently/Core/Caching/Shared%20Prefrences/shared_pref.dart';
import 'package:evently/Core/Models/user_model.dart';
import 'package:evently/Core/Firebase/firebase_manager.dart';
import 'package:injectable/injectable.dart';

abstract class HomeScreenDS {
  Future<UserModel?> getCurrUser();
  Future<void> toggleFavorite(String eventId, bool currentValue);
}
@Named("remote")
@Injectable(as: HomeScreenDS)
class HomeScreenRemoteDSImp extends HomeScreenDS {

  @override
  Future<void> toggleFavorite(String eventId, bool currentValue) async {
    await FirebaseManager.eventsCollection()
        .doc(eventId)
        .update({'isFav': !currentValue});
  }

  @override
  Future<UserModel?> getCurrUser() async {
    final user = PreferencesHelper.getActiveUser();
    if (user == null) return null;

    final doc =
    await FirebaseManager.usersCollection().doc(user).get();
    if(doc.data()!=null){
      HiveHelper.storeUser(doc.data()!);
    }


    return doc.data();
  }
}

@Named("local")
@Injectable(as: HomeScreenDS)
class HomeScreenLocalDSImp extends HomeScreenDS {

  @override
  Future<void> toggleFavorite(String eventId, bool currentValue) async {
    await HiveHelper.toggleEvent(eventId);
  }

  @override
  Future<UserModel?> getCurrUser() async {
     UserModel? user=await HiveHelper.getStoredUser();
     return user;
  }
}
