import 'package:evently/Core/Models/user_model.dart';

abstract class AuthRepo{
  Future<void> signup({required UserModel user, required String password});
  Future<void> signIn({required String email, required String password});
  Future<void> resetPass({required String email});
}