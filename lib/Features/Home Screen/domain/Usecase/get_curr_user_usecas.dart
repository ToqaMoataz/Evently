import 'package:evently/Features/Home%20Screen/domain/Repository/home_screen_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../../Core/Models/user_model.dart';

@injectable
class GetCurrUserUC{
  HomeScreenRepo repo;
  GetCurrUserUC(this.repo);

  Future<UserModel?> call(bool isConnected) async {
    try{
      UserModel? user= await repo.getCurrUser(isConnected: isConnected);
      return user;
    }on FirebaseAuthException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}