import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/Core/Models/event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../../../Core/Firebase/firebase_manager.dart';

abstract class FaveTabDS{

  Stream<QuerySnapshot<EventModel>> getFavEvents();
}

class FaveTabDSImp extends FaveTabDS {

  @override
  Stream<QuerySnapshot<EventModel>> getFavEvents() {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return Stream.empty();
      return FirebaseManager.eventsCollection()
            .where("userId", isEqualTo: user.uid)
            .where('isFav', isEqualTo: true)
            .snapshots();

    } catch (e) {
      rethrow;
    }
  }


}

