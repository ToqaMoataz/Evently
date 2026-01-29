import 'package:evently/Core/assets/const%20data.dart';
import '../../../../../../../Core/Models/event_model.dart';
import '../../../../../../../Core/Models/user_model.dart';

abstract class HomeTabStates {}

class HomeTabInitState extends HomeTabState {}

class HomeTabState extends HomeTabStates {
  final String? errorMessage;
  final RequestState getEventsRequestState;
  final RequestState getUserInfoRequestState;
  final RequestState toggleEventFavRequestState;
  final int categoryIndex;
  final List<EventModel> events;
  final UserModel? currUser;

  HomeTabState({
    this.errorMessage,
    this.getEventsRequestState = RequestState.init,
    this.getUserInfoRequestState = RequestState.init,
    this.categoryIndex = 0,
    this.events = const [],
    this.currUser,
    this.toggleEventFavRequestState = RequestState.init,
  });

  HomeTabState copyWith({
    String? errorMessage,
    RequestState? getEventsRequestState,
    RequestState? getUserInfoRequestState,
    int? categoryIndex,
    List<EventModel>? events,
    UserModel? currUser,
    RequestState? toggleEventFavRequestState,
  }) {
    return HomeTabState(
      errorMessage: errorMessage ?? this.errorMessage,
      getEventsRequestState:
      getEventsRequestState ?? this.getEventsRequestState,
      getUserInfoRequestState:
      getUserInfoRequestState ?? this.getUserInfoRequestState,
      categoryIndex: categoryIndex ?? this.categoryIndex,
      events: events ?? this.events,
      currUser: currUser ?? this.currUser,
      toggleEventFavRequestState: toggleEventFavRequestState ?? this.toggleEventFavRequestState,
    );
  }
}
