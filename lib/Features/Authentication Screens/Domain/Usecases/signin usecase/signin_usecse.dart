import 'package:evently/Features/Authentication%20Screens/Domain/Repository/repo.dart';
import 'package:injectable/injectable.dart';
@injectable
class SignInUC{
  AuthRepo repo;
  SignInUC(this.repo);

  Future<void> call({required String email,required String password})async {
    try{
      await repo.signIn(email: email, password: password);
    }catch(e){
      rethrow;
    }
  }
}