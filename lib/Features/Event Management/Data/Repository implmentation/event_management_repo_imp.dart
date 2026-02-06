

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/Core/Models/event_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import '../../../../Core/Models/place_model.dart';
import '../../Domain/Repository/event_management_repo.dart';
import '../Data source/event_management_ds.dart';
@Injectable(as: EventManagementRepo)
class EventManagementRepoImp extends EventManagementRepo{
  EventManagementDS ds;
  EventManagementRepoImp(this.ds);
  @override
  Future<void> addEvent(EventModel event) async {
    try{
      await ds.addEvent(event);
    }catch(e){rethrow;}
  }

  @override
  Future<void> deleteEvent(String eventId) async {
    try {
      await ds.deleteEvent(eventId);
    } on FirebaseException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateEvent(EventModel event) async {
    try {
      await ds.updateEvent(event);
    } on FirebaseException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<PlaceModel>?> searchPlace(String query) async {
    try {
      List<PlaceModel>? location=await ds.searchPlace(query);
      return location;
    } catch (e) {
      rethrow;
    }
  }


}