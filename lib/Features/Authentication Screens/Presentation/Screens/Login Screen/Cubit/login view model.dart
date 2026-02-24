
import 'package:evently/Features/Authentication%20Screens/Domain/Usecases/signin%20usecase/signin_usecse.dart';
import 'package:evently/Features/Authentication%20Screens/Presentation/Screens/Login%20Screen/Cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../../Core/assets/const data.dart';

@injectable
class LoginViewModel extends Cubit<LoginState>{
  SignInUC useCase;
  LoginViewModel(this.useCase) : super(LoginInitState());

  void togglePasswordVisibility() {
    emit(state.copyWith(passwordVisible: !state.passwordVisible));
  }

  void opacityOff() {
    emit(state.copyWith(opacity: 1));
  }

  Future<void> login(String email,String password) async {
    print("ITS CALLED");
    try{
      emit(state.copyWith(loginRequestState: RequestState.loading,opacity: 0.5));
      print("STATEEEE: ${state.loginRequestState}");
      await useCase.call(email: email, password: password);
      emit(state.copyWith(loginRequestState: RequestState.success));
      print("STATEEEE: ${state.loginRequestState}");
    } on FirebaseAuthException catch(e) {
      print("FirebaseAuthException: ${e.code}");
      emit(state.copyWith(loginRequestState: RequestState.error,errorMessage: e.toString(),opacity: 0.5));
      print("STATEEEE: ${state.loginRequestState}");
    } catch(e) {
      print("Other exception: $e");
      emit(state.copyWith(loginRequestState: RequestState.error,errorMessage: e.toString()));
      print("STATEEEE: ${state.loginRequestState}");
    }
  }

}