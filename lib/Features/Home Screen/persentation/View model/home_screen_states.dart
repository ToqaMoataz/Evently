import 'package:evently/Core/Models/user_model.dart';

import '../../../../Core/assets/const data.dart';

abstract class HomeScreenStates {}

class HomeScreenInitState extends HomeScreenState {}

class HomeScreenState extends HomeScreenStates {
  final String? errorMessage;
  final int currentTabIndex;
  final UserModel? currUser;
  final RequestState getUserInfoRequestState;


  HomeScreenState({
    this.errorMessage,
    this.currentTabIndex = 0,
    this.currUser,
    this.getUserInfoRequestState = RequestState.init,
  });

  HomeScreenState copyWith({String? errorMessage, int? currentTabIndex,RequestState? getUserInfoRequestState, UserModel? currentUser}) {
    return HomeScreenState(
      getUserInfoRequestState:
      getUserInfoRequestState ?? this.getUserInfoRequestState,
      errorMessage: errorMessage ?? this.errorMessage,
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
      currUser: currUser ?? currentUser,
    );
  }
}
