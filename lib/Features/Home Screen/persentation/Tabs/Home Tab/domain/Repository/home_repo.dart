import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../../../Core/Models/event_model.dart';

abstract class HomeRepo{
  Stream<QuerySnapshot<EventModel>> getUserEvents(String category);
}