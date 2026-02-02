import 'package:evently/Core/assets/const%20data.dart';
import '../../../../../../../Core/Models/event_model.dart';
import '../../../../../../../Core/Models/user_model.dart';

abstract class HomeTabStates {}

class HomeTabInitState extends HomeTabState {}

class HomeTabState extends HomeTabStates {
  final String? errorMessage;
  final String? userLocation;
  final RequestState getEventsRequestState;

  final RequestState toggleEventFavRequestState;
  final int categoryIndex;
  final List<EventModel> events;

  HomeTabState({
    this.errorMessage,
    this.userLocation,
    this.getEventsRequestState = RequestState.init,

    this.categoryIndex = 0,
    this.events = const [],
    this.toggleEventFavRequestState = RequestState.init,
  });

  HomeTabState copyWith({
    String? errorMessage,
    String? userLocation,
    RequestState? getEventsRequestState,
    int? categoryIndex,
    List<EventModel>? events,
    RequestState? toggleEventFavRequestState,
  }) {
    return HomeTabState(
      errorMessage: errorMessage ?? this.errorMessage,
      userLocation: userLocation ?? this.userLocation,
      getEventsRequestState:
      getEventsRequestState ?? this.getEventsRequestState,
      categoryIndex: categoryIndex ?? this.categoryIndex,
      events: events ?? this.events,
      toggleEventFavRequestState: toggleEventFavRequestState ?? this.toggleEventFavRequestState,
    );
  }
}
