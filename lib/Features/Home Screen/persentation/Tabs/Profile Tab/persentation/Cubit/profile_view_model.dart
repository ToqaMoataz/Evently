import 'package:bloc/bloc.dart';
import 'package:evently/Features/Home%20Screen/domain/Usecase/get_curr_user_usecas.dart';
import 'package:evently/Features/Home%20Screen/persentation/Tabs/Profile%20Tab/domain/Usecase/logout_usecase.dart';
import 'package:evently/Features/Home%20Screen/persentation/Tabs/Profile%20Tab/domain/Usecase/upload_image_usecase.dart';
import 'package:evently/Features/Home%20Screen/persentation/Tabs/Profile%20Tab/persentation/Cubit/profile_states.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../Core/assets/const data.dart';
@injectable
class ProfileViewModel extends Cubit<ProfileState> {
  UploadUserImageUC uploadUC;
  GetCurrUserUC getCurrUserUC;
  LogoutUC logoutUC;

  ProfileViewModel({required this.uploadUC,required this.getCurrUserUC,required this.logoutUC}):super(ProfileInitState());

  Future<void> getCurrUser() async {
    emit(state.copyWith(
      getUserInfoRequestState: RequestState.loading,
    ));

    try {
      final user = await getCurrUserUC.call();
      if (isClosed) return;
      if (user == null) {
        emit(state.copyWith(
          getUserInfoRequestState: RequestState.error,
          errorMessage: 'User not found',
        ));
        return;
      }

      emit(state.copyWith(
        getUserInfoRequestState: RequestState.success,
        currUser: user,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(
        getUserInfoRequestState: RequestState.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> uploadUserImage()async {
    emit(state.copyWith(uploadUserImageRequestState: RequestState.loading));
    try{
      await uploadUC.call();
      await getCurrUser();
      emit(state.copyWith(uploadUserImageRequestState: RequestState.success));
    }catch(e){
      emit(state.copyWith(uploadUserImageRequestState: RequestState.error,errorMessage: e.toString()));
    }
  }

  Future<void> logout() async {
    emit(state.copyWith(logoutRequestState: RequestState.loading));
    try {
      await logoutUC.call();
      emit(state.copyWith(logoutRequestState: RequestState.success));
    } catch (e) {
      emit(state.copyWith(logoutRequestState: RequestState.error,errorMessage: e.toString()));
    }
  }


}