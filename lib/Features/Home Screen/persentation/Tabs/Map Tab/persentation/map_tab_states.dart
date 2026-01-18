import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:evently/Core/assets/const data.dart';

import '../../../../../../Core/Models/event_model.dart';

abstract class MapTabStates {}

class MapTabState extends MapTabStates {
  final RequestState getUserEventsRequestState;
  final LatLng? currentEventPosition;
  final Marker? marker;
  final String? errorMessage;
  final List<EventModel> events;

  MapTabState({
    this.getUserEventsRequestState = RequestState.init,
    this.currentEventPosition,
    this.marker,
    this.errorMessage,
    this.events = const [],
  });

  MapTabState copyWith({
    RequestState? getUserEventsRequestState,
    LatLng? currentEventPosition,
    Marker? marker,
    String? errorMessage,
    List<EventModel>? events,
  }) {
    return MapTabState(
      getUserEventsRequestState:
      getUserEventsRequestState ?? this.getUserEventsRequestState,
      currentEventPosition:
      currentEventPosition ?? this.currentEventPosition,
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
    currentEventPosition: null,
    marker: null,
    errorMessage: null,
  );
}
