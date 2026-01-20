import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../Core/assets/const data.dart';

abstract class EventFormStates {}

class EventFormState extends EventFormStates {
  final RequestState createEventRequestState;
  final RequestState setPositionRequestState;
  final LatLng? currentPosition;
  final String? currentLocation;
  final String? errorMessage;
  final Marker? marker;

  final int selectedEvent;
  final DateTime? eventDate;
  final TimeOfDay? eventTime;

  EventFormState({
    this.createEventRequestState = RequestState.init,
    this.setPositionRequestState = RequestState.init,
    this.currentPosition,
    this.currentLocation,
    this.errorMessage,
    this.marker,
    this.selectedEvent = 1,
    this.eventDate,
    this.eventTime,
  });

  EventFormState copyWith({
    RequestState? createEventRequestState,
    RequestState? setPositionRequestState,
    LatLng? currentPosition,
    String? currentLocation,
    String? errorMessage,
    Marker? marker,
    int? selectedEvent,
    DateTime? eventDate,
    TimeOfDay? eventTime,
  }) {
    return EventFormState(
      createEventRequestState:
      createEventRequestState ?? this.createEventRequestState,
      setPositionRequestState:
      setPositionRequestState ?? this.setPositionRequestState,
      currentPosition: currentPosition ?? this.currentPosition,
      currentLocation: currentLocation ?? this.currentLocation,
      errorMessage: errorMessage ?? this.errorMessage,
      marker: marker ?? this.marker,
      selectedEvent: selectedEvent ?? this.selectedEvent,
      eventDate: eventDate ?? this.eventDate,
      eventTime: eventTime ?? this.eventTime,
    );
  }
}

class EventFormInitState extends EventFormState {
  EventFormInitState()
      : super(
    createEventRequestState: RequestState.init,
    setPositionRequestState: RequestState.init,
    currentPosition: null,
    currentLocation: null,
    marker: null,
    selectedEvent: 1,
    eventDate: null,
    eventTime: null,
  );
}
