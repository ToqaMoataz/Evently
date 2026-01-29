import 'package:evently/Core/Models/user_model.dart';
import 'package:evently/Features/Authentication%20Screens/Data/data%20source/auth_ds.dart';
import 'package:evently/Features/Authentication%20Screens/Domain/Repository/repo.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: AuthRepo)
class AuthRepoImpl extends AuthRepo{
  AuthDs ds;
  AuthRepoImpl({required this.ds});
  @override
  Future<void> signIn({required String email, required String password}) async {
    try{
      await ds.signIn(email: email, password: password);
    }catch(e){
      rethrow;
    }

  }

  @override
  Future<void> signup({required UserModel user, required String password}) async {
    try{
      await ds.signup(user: user, password: password);
    }catch(e){
      rethrow;
    }

  }

  @override
  Future<void> resetPass({required String email}) async {
    try{
      await ds.resetPass(email: email);
    }catch(e){
      rethrow;
    }
  }

}