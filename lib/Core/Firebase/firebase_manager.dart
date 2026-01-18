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