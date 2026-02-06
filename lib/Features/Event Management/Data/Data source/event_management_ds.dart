import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/Core/Firebase/firebase_manager.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import '../../../../Core/Models/event_model.dart';
import '../../../../Core/Models/place_model.dart';

abstract class EventManagementDS{
  Future<void> addEvent(EventModel event);
  Future<void> updateEvent(EventModel event);
  Future<void> deleteEvent(String eventId);
  Future<List<PlaceModel>?> searchPlace(String query);
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



  @override
  Future<List<PlaceModel>?> searchPlace(String query) async {
    String lang="en";
    int limit=20;
    final Uri url = Uri.parse(
        'https://nominatim.openstreetmap.org/search'
            '?q=$query'
            '&format=json'
            '&limit=$limit'
            '&accept-language=$lang'
            '&viewbox=24.7,31.7,36.9,22.0' // Egypt
            '&bounded=1'
    );


    final response = await http.get(
      url,
      headers: {
        'User-Agent': 'Evently',
      },
    );

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => PlaceModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to search places: ${response.statusCode}');
    }
  }
}
