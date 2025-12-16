import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Models/event_model.dart';
import '../Models/user_model.dart';

class FirebaseManager{

  //Events//
  static  CollectionReference<EventModel> eventsCollection(){
    return FirebaseFirestore.instance.collection("Events").withConverter(
        fromFirestore: (snapshot,_){
          return EventModel.fromJson(snapshot.data()!,snapshot.id,);
        },
        toFirestore: (model,_){
          return model.toJson();
        }
    );
  }

  static Future<void> addEvent(EventModel event) async{
    var snapshot=eventsCollection().doc();
    event.id=snapshot.id;
    await snapshot.set(event);
  }




  //Edit Event
  static Future<void> editEvent(EventModel model) async {
    try {
      if (model.id.isEmpty) {
        throw Exception("Event is empty");
      }
      await eventsCollection()
          .doc(model.id)
          .set(model);
      print("Event edited successfully");
    } catch (e) {
      print("Failed to edit event: $e");
    }
  }

  static Future<void> deleteEvent(String id) async {
    try {
      await eventsCollection().doc(id).delete();
      print("Event deleted successfully: $id");
    } catch (e) {
      print("Failed to delete event: $e");
    }
  }


  //Users//
  static  CollectionReference<UserModel> usersCollection() {
    return FirebaseFirestore.instance.collection("Users").withConverter(
        fromFirestore: (snapshot, _) {
          return UserModel.fromJson(snapshot.data()!);
        },
        toFirestore: (model, _) {
          return model.toJson();
        }
    );
  }



}