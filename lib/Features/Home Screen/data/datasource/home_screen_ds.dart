import 'package:evently/Core/Models/user_model.dart';
import 'package:evently/Core/Firebase/firebase_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract class HomeScreenDS {
  Future<UserModel?> getCurrUser();
  Future<void> toggleFavorite(String eventId, bool currentValue);
}

@Injectable(as: HomeScreenDS)
class HomeScreenDSImp extends HomeScreenDS {

  @override
  Future<void> toggleFavorite(String eventId, bool currentValue) async {
    await FirebaseManager.eventsCollection()
        .doc(eventId)
        .update({'isFav': !currentValue});
  }

  @override
  Future<UserModel?> getCurrUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;

    final doc =
    await FirebaseManager.usersCollection().doc(user.uid).get();

    return doc.data();
  }
}
