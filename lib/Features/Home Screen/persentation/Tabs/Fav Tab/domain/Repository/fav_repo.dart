import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../../../Core/Models/event_model.dart';

abstract class FavRepo{
  Stream<QuerySnapshot<EventModel>> getFavEvents();
}