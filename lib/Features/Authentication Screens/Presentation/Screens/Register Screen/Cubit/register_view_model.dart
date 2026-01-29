import 'package:bloc/bloc.dart';
import 'package:evently/Features/Authentication%20Screens/Domain/Usecases/sign%20up%20usecase/signup_usecse.dart';
import 'package:evently/Features/Authentication%20Screens/Presentation/Screens/Register%20Screen/Cubit/states.dart';
import 'package:injectable/injectable.dart';


import '../../../../../../Core/Models/user_model.dart';
import '../../../../../../Core/assets/const data.dart';
@injectable
class RegisterViewModel extends Cubit<RegisterState>{
  SignupUC useCase;
  RegisterViewModel(this.useCase) : super(RegisterInitState());

  void togglePasswordVisibility() {
    emit(state.copyWith(passVisible: !state.passVisible));
  }
  void toggleRePasswordVisibility() {
    emit(state.copyWith(rePassVisible: !state.rePassVisible));
  }

  void opacityOff(){
    emit(state.copyWith(opacity: 1));
  }

  Future<void> createAcc({required UserModel user,required String password})async {
    try{
      emit(state.copyWith(registerRequestState: RequestState.loading,opacity: 0.5));
      await useCase.call(user: user, password: password);
      emit(state.copyWith(registerRequestState: RequestState.success));
    }catch(e){
      emit(state.copyWith(registerRequestState: RequestState.error,errorMessage: e.toString(),opacity: 0.5));
    }
  }

}