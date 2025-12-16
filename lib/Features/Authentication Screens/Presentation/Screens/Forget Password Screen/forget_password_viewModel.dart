import 'package:bloc/bloc.dart';
import 'package:evently/Features/Authentication%20Screens/Domain/Usecases/forget%20password%20usecase/forget_password_usecse.dart';
import 'package:evently/Features/Authentication%20Screens/Presentation/Screens/Forget%20Password%20Screen/states.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../Core/assets/const data.dart';

class ForgetPasswordViewModel extends Cubit<ForgetPassState>{
  ForgetPassUC useCase;
  ForgetPasswordViewModel(this.useCase):super(ForgetPassInitialState());

  void opacityOff(){
    emit(state.copyWith(opacity: 1));
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    emit(state.copyWith(forgetPassRequestState: RequestState.loading, opacity: 0.5));
    print("STATE:${state.forgetPassRequestState}");
    try {
      await useCase.call(email: email);
      emit(state.copyWith(forgetPassRequestState: RequestState.success, opacity: 1));
      print("STATE:${state.forgetPassRequestState}");
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(
        forgetPassRequestState: RequestState.error,
        errorMessage: e.message,
        opacity: 0.5,
      ));
      print("STATE:${state.forgetPassRequestState}");
    } catch (e) {
      emit(state.copyWith(
        forgetPassRequestState: RequestState.error,
        errorMessage: e.toString(),
        opacity: 0.5,
      ));
      print("STATE:${state.forgetPassRequestState}");
    }
  }



}