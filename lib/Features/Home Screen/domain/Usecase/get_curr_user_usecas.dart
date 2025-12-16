import 'package:evently/Features/Home%20Screen/domain/Repository/home_screen_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../Core/Models/user_model.dart';

class GetCurrUserUC{
  HomeScreenRepo repo;
  GetCurrUserUC(this.repo);

  Future<UserModel?> call() async {
    try{
      UserModel? user= await repo.getCurrUser();
      return user;
    }on FirebaseAuthException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}