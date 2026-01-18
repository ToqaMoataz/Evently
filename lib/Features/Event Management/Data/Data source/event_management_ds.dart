import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/Core/Firebase/firebase_manager.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:location/location.dart';


import '../../../../Core/Models/event_model.dart';

abstract class EventManagementDS{
  Future<void> addEvent(EventModel event);
  Future<void> updateEvent(EventModel event);
  Future<void> deleteEvent(String eventId);
  Future<LatLng?> getCurrentPosition();
  Future<Placemark?> getUserLocation(LatLng position);
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
  Future<Placemark?> getUserLocation(LatLng position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    return placemarks.first;
  }
  @override
  Future<LatLng?> getCurrentPosition() async {
    Location location = Location();
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return null;
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return null;
    }

    final locData = await location.getLocation();
    LatLng? currentPosition=LatLng(locData.latitude!, locData.longitude!);

    return currentPosition;
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