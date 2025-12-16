import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/Core/Models/event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../../../Core/Firebase/firebase_manager.dart';

abstract class HomeTabDS{

  Stream<QuerySnapshot<EventModel>> getUserEvents(String category);

  Stream<QuerySnapshot<EventModel>> filterEvents(String category,String userId);
}

class HomeTabDSImp extends HomeTabDS {

  @override
  Stream<QuerySnapshot<EventModel>> getUserEvents(String category) {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return Stream.empty();
      if(category=="All"){
        return FirebaseManager.eventsCollection()
            .where("userId", isEqualTo: user.uid)
            .snapshots();
      }
      return filterEvents(category,user.uid);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<QuerySnapshot<EventModel>> filterEvents(String category,String userId) {
    Stream<QuerySnapshot<EventModel>> reference = FirebaseManager.eventsCollection()
        .where("userId", isEqualTo: userId)
        .where('eventCategory', isEqualTo: category)
        .snapshots();
    return reference;
  }
}

