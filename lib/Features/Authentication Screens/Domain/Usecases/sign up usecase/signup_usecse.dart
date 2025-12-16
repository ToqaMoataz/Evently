import 'package:evently/Features/Authentication%20Screens/Domain/Repository/repo.dart';

import '../../../../../Core/Models/user_model.dart';

class SignupUC{
  AuthRepo repo;
  SignupUC(this.repo);

  Future<void> call({required UserModel user,required String password})async {
    try{
      await repo.signup(user: user, password: password);
    }catch(e){
      rethrow;
    }
  }
}