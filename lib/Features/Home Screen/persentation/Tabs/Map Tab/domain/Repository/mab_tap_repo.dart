import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../../../Core/Models/event_model.dart';

abstract class MapTabRepo {

  Stream<QuerySnapshot<EventModel>>? getAllUserEvents();
}