

import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../Core/Models/event_model.dart';

abstract class EventManagementRepo{
  Future<void> addEvent(EventModel event);
  Future<void> updateEvent(EventModel event);
  Future<void> deleteEvent(String eventId);
  Future<LatLng?> getCurrentPosition();
  Future<Placemark?> getUserLocation(LatLng position);
}