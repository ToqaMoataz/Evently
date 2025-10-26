import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:evently/Models/event_model.dart';

import '../Models/user_model.dart';

class FirebaseManager{

  //Events//
  static  CollectionReference<EventModel> eventsCollection(){
    return FirebaseFirestore.instance.collection("Events").withConverter(
        fromFirestore: (snapshot,_){
          return EventModel.fromJson(snapshot.data()!);
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

  static Stream<QuerySnapshot<EventModel>> getEvents(){
    Stream<QuerySnapshot<EventModel>> reference= eventsCollection().snapshots();
    return reference;
  }

  static Stream<QuerySnapshot<EventModel>> filterEvents(String category) {
    Stream<QuerySnapshot<EventModel>> reference = eventsCollection()
        .where('eventCategory', isEqualTo: category) // filter by category
        .snapshots();
    return reference;
  }

  //Edit Event
  static Future<void> editEvent(EventModel model) async {
    try {
      if (model.id == null || model.id!.isEmpty) {
        throw Exception("Task ID is null or empty");
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


  static addUser(UserModel user) async{
    //usersCollection().add(user);
    var snapshot=usersCollection().doc(user.id);
    user.id=snapshot.id;
    await snapshot.set(user);
  }


  static signup({required UserModel user, required String password,required Function onFail,required Function onSucess}) async{
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );
      credential.user!.sendEmailVerification();
      user.id=credential.user!.uid;
      addUser(user);
      onSucess();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      onFail(e.code);
    } catch (e) {
      print(e);
    }
  }

  static signin({required String email,required String password,required Function onSucess,required Function onFail}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      onSucess();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      onFail(e.code);
    }
  }
}