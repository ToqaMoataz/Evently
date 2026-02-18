

import '../../../../../../../Core/Models/event_model.dart';

abstract class FavRepo{
  Future<List<EventModel>> getFavEvents(bool isConnected);
}