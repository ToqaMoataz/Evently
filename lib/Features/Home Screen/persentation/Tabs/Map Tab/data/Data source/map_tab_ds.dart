import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../Core/Firebase/firebase_manager.dart';
import '../../../../../../../Core/Models/event_model.dart';

abstract class MapTabDs {
  Stream<QuerySnapshot<EventModel>>? getAllUserEvents();
}

@Injectable(as: MapTabDs)
class MapTabDsImp extends MapTabDs {
  @override
  Stream<QuerySnapshot<EventModel>>? getAllUserEvents() {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return Stream.empty();
      Stream<QuerySnapshot<EventModel>>? reference =
          FirebaseManager.eventsCollection()
              .where("userId", isEqualTo: user.uid)
              .snapshots();
      return reference;
    } catch (e) {
      rethrow;
    }
  }
}
