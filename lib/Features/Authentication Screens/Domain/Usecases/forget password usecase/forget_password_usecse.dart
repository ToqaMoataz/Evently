import 'package:evently/Features/Authentication%20Screens/Domain/Repository/repo.dart';

class ForgetPassUC{
  AuthRepo repo;
  ForgetPassUC(this.repo);

  Future<void> call({required String email})async{
    try{
      await repo.resetPass(email: email);
    }catch(e){
      rethrow;
    }
  }
}