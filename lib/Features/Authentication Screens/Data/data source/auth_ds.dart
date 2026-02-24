import 'package:evently/Core/Firebase/firebase_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../../Core/Caching/Shared Prefrences/shared_pref.dart';
import '../../../../Core/Models/user_model.dart';

abstract class AuthDs {
  Future<void> _addUser(UserModel user);

  Future<void> signup({required UserModel user, required String password});

  Future<void> signIn({required String email, required String password});

  Future<void> resetPass({required String email});
}

@Injectable(as: AuthDs)
class AuthDsImp extends AuthDs {
  PreferencesHelper helper = PreferencesHelper();

  @override
  Future<void> _addUser(UserModel user) async {
    await FirebaseManager.usersCollection().doc(user.id).set(user);
  }

  @override
  Future<void> signup({
    required UserModel user,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: user.email,
            password: password,
          );

      await credential.user!.sendEmailVerification();

      user.id = credential.user!.uid;
      await _addUser(user);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          throw 'Password is too weak.';

        case 'email-already-in-use':
          throw 'An account already exists for this email.';

        case 'invalid-email':
          throw 'Invalid email format.';

        case 'operation-not-allowed':
          throw 'Email/password accounts are not enabled.';

        case 'too-many-requests':
          throw 'Too many attempts. Please try again later.';

        default:
          throw e.message ?? 'Sign up failed. Please try again.';
      }
    }
  }

  @override
  Future<void> signIn({required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      PreferencesHelper.setActiveUser(credential.user!.uid);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          throw 'Invalid email format.';

        case 'invalid-credential':
          throw 'Email or password is incorrect.';

        case 'too-many-requests':
          throw 'Too many login attempts. Please try again later.';

        default:
          throw e.message ?? 'Authentication failed.';
      }
    }
  }

  Future<bool> _checkEmail(String email) async {
    final snapshot =
        await FirebaseManager.usersCollection()
            .where('email', isEqualTo: email)
            .limit(1)
            .get();
    if (snapshot.docs.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  Future<void> resetPass({required String email}) async {
    try {
      bool exists = await _checkEmail(email);
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
