import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/Core/Firebase/firebase_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../Core/Models/user_model.dart';

abstract class AuthDs{
  Future<void> addUser(UserModel user);
  Future<void> signup({required UserModel user, required String password});
  Future<void> signIn({required String email,required String password});
  Future<void> resetPass({required String email});
}

class AuthDsImp extends AuthDs{
  @override
  Future<void> addUser(UserModel user) async {
    await FirebaseManager.usersCollection()
        .doc(user.id)
        .set(user);
  }

  @override
  Future<void> signup({required UserModel user, required String password}) async{
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );
      await credential.user!.sendEmailVerification();
      user.id=credential.user!.uid;
      await addUser(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      rethrow;
      // onFail(e.code);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<void> signIn({required String email,required String password}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      rethrow;
      // onFail(e.code);
    }
  }

  Future<bool> checkEmail(String email) async {
    final snapshot = await FirebaseManager.usersCollection()
        .where('email', isEqualTo: email).limit(1).get();
    if (snapshot.docs.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  Future<void> resetPass({required String email}) async {
    try {
      bool exists = await checkEmail(email);
      if (!exists) {
        throw FirebaseAuthException(
          code: 'user-not-found',
          message: 'No user found with this email in Firestore.',
        );
      }
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw FirebaseAuthException(
          code: 'user-not-found-auth',
          message: 'User is not found.',
        );
      } else {
        rethrow;
      }
    } catch (e) {
      throw Exception('Something went wrong while resetting password.');
    }
  }





}