import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/Core/Firebase/firebase_manager.dart';
import 'package:injectable/injectable.dart';
import '../../../../Core/Models/event_model.dart';

abstract class EventManagementDS{
  Future<void> addEvent(EventModel event);
  Future<void> updateEvent(EventModel event);
  Future<void> deleteEvent(String eventId);
}

@Injectable(as: EventManagementDS)
class EventManagementDSImp extends EventManagementDS{
  @override
  Future<void> addEvent(EventModel event) async{
    try {
      var snapshot = FirebaseManager.eventsCollection().doc();
      event.id = snapshot.id;
      await snapshot.set(event);
    }on FirebaseException catch (e) {
      throw Exception("Failed to Create event: ${e.message}");
    }catch (e) {
      rethrow;
    }
  }


  @override
  Future<void> updateEvent(EventModel event) async {
    try {
      await FirebaseManager.eventsCollection()
          .doc(event.id)
          .update(event.toJson());
    } on FirebaseException catch (e) {
      throw Exception(
        e.message ?? 'Failed to edit event. Please try again.',
      );
    } catch (e) {
      throw Exception('Unexpected error occurred');
    }
  }

  @override
  Future<void> deleteEvent(String eventId) async {
    try {
      await FirebaseManager.eventsCollection()
          .doc(eventId)
          .delete();
    } on FirebaseException catch (e) {
      throw Exception(
        e.message ?? 'Failed to delete event. Please try again.',
      );
    } catch (e) {
      throw Exception('Unexpected error occurred');
    }
  }




}