import '../../../../Core/assets/const data.dart';

abstract class HomeScreenStates {}

class HomeScreenInitState extends HomeScreenState {}

class HomeScreenState extends HomeScreenStates {
  final String? errorMessage;
  final int currentTabIndex;

  HomeScreenState({this.errorMessage, this.currentTabIndex = 0});

  HomeScreenState copyWith({String? errorMessage, int? currentTabIndex}) {
    return HomeScreenState(
      errorMessage: errorMessage ?? this.errorMessage,
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
    );
  }
}
