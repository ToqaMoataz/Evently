import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../../../Core/Models/event_model.dart';

abstract class HomeRepo{
  Future<List<EventModel>> getUserEvents(String category,bool isConnected);
}