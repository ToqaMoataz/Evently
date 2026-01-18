
import 'package:evently/Core/Models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../../../../../Core/Firebase/firebase_manager.dart';

abstract class HomeScreenDS{
  Future<UserModel?> getCurrUser();
  Future<void> toggleFavorite(String eventId, bool currentValue);
}

class HomeScreenDSImp extends HomeScreenDS {

  @override
  Future<void> toggleFavorite(String eventId, bool currentValue) async {
    try {
      await FirebaseManager.eventsCollection()
          .doc(eventId)
          .update({
        'isFav': !currentValue,
      });
    } on FirebaseException catch (e) {
      print('Firebase error: ${e.message}');
      rethrow;
    } catch (e) {
      print('Unexpected error: $e');
      rethrow;
    }
  }


  @override
  Future<UserModel?> getCurrUser() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return null;

      final doc = await FirebaseManager.usersCollection().doc(user.uid).get();
      if (!doc.exists) return null;

      return doc.data();
    } on FirebaseAuthException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }


}

