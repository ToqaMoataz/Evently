import 'package:evently/Core/assets/const data.dart';
import '../../../../../../../Core/Models/event_model.dart';

abstract class FavTabStates {}

class FavTabInitState extends FavTabState {}

class FavTabState extends FavTabStates {
  final RequestState getFavEventsRequestState;
  final RequestState searchEventsRequestState;
  final RequestState toggleEventFavRequestState;
  final String? errorMessage;
  final List<EventModel> events;
  final List<EventModel> searchResults;

  FavTabState({
    this.getFavEventsRequestState = RequestState.init,
    this.searchEventsRequestState = RequestState.init,
    this.toggleEventFavRequestState = RequestState.init,
    this.errorMessage,
    this.events = const [],
    this.searchResults = const [],
  });

  FavTabState copyWith({
    RequestState? getFavEventsRequestState,
    RequestState? searchEventsRequestState,
    RequestState? toggleEventFavRequestState,
    String? errorMessage,
    List<EventModel>? events,
    List<EventModel>? searchResults,
  }) {
    return FavTabState(
      getFavEventsRequestState: getFavEventsRequestState ?? this.getFavEventsRequestState,
      searchEventsRequestState: searchEventsRequestState ?? this.searchEventsRequestState,
      toggleEventFavRequestState: toggleEventFavRequestState ?? this.toggleEventFavRequestState,
      errorMessage: errorMessage ?? this.errorMessage,
      events: events ?? this.events,
      searchResults: searchResults ?? this.searchResults,
    );
  }
}
