import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../../../Core/Models/event_model.dart';
import '../../../../../../../Core/assets/const data.dart';

abstract class MapTabStates {}

class MapTabState extends MapTabStates {
  final RequestState getUserEventsRequestState;
  final RequestState setPositionRequestState;
  final LatLng? currentEventPosition;
  final Marker? marker;
  final String? errorMessage;
  final List<EventModel> events;

  MapTabState({
    this.getUserEventsRequestState = RequestState.init,
    this.setPositionRequestState = RequestState.init,
    this.currentEventPosition,
    this.marker,
    this.errorMessage,
    this.events = const [],
  });

  MapTabState copyWith({
    RequestState? getUserEventsRequestState,
    RequestState? setPositionRequestState,
    LatLng? currentEventPosition,
    Marker? marker,
    String? errorMessage,
    List<EventModel>? events,
  }) {
    return MapTabState(
      getUserEventsRequestState:
      getUserEventsRequestState ?? this.getUserEventsRequestState,
      setPositionRequestState:
      setPositionRequestState ?? this.setPositionRequestState,
      currentEventPosition: currentEventPosition ?? this.currentEventPosition,
      marker: marker ?? this.marker,
      errorMessage: errorMessage ?? this.errorMessage,
      events: events ?? this.events,
    );
  }
}

class MapTabInitState extends MapTabState {
  MapTabInitState()
      : super(
    getUserEventsRequestState: RequestState.init,
    setPositionRequestState: RequestState.init,
    currentEventPosition: null,
    marker: null,
    errorMessage: null,
    events: const [],
  );
}
