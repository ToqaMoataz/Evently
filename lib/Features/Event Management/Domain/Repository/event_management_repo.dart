

import '../../../../Core/Models/event_model.dart';
import '../../../../Core/Models/place_model.dart';

abstract class EventManagementRepo{
  Future<void> addEvent(EventModel event);
  Future<void> updateEvent(EventModel event);
  Future<void> deleteEvent(String eventId);
  Future<List<PlaceModel>?> searchPlace(String query);
}