import 'package:evently/Core/assets/const%20data.dart';
import '../../../../../../../Core/Models/user_model.dart';

abstract class ProfileStates {}

class ProfileInitState extends ProfileState {}

class ProfileState extends ProfileStates {
  final RequestState getUserInfoRequestState;
  final RequestState uploadUserImageRequestState;
  final RequestState logoutRequestState;
  final String? errorMessage;
  final UserModel? currUser;

  ProfileState({
    this.getUserInfoRequestState = RequestState.init,
    this.uploadUserImageRequestState = RequestState.init,
    this.logoutRequestState = RequestState.init,
    this.errorMessage,
    this.currUser,
  });

  ProfileState copyWith({
    RequestState? getUserInfoRequestState,
    RequestState? uploadUserImageRequestState,
    RequestState? logoutRequestState,
    String? errorMessage,
    UserModel? currUser,
  }) {
    return ProfileState(
      getUserInfoRequestState:
      getUserInfoRequestState ?? this.getUserInfoRequestState,
      uploadUserImageRequestState:
      uploadUserImageRequestState ?? this.uploadUserImageRequestState,
      logoutRequestState:
      logoutRequestState ?? this.logoutRequestState,
      errorMessage: errorMessage ?? this.errorMessage,
      currUser: currUser ?? this.currUser,
    );
  }
}
