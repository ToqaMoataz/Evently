import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../Core/Models/place_model.dart';
import '../../../../../Core/assets/const data.dart';

abstract class EventFormStates {}

class EventFormState extends EventFormStates {
  final RequestState createEventRequestState;
  final RequestState updateEventRequestState;
  final RequestState deleteEventRequestState;
  final RequestState setPositionRequestState;
  final RequestState searchRequestState;

  final LatLng? currentPosition;
  final String? currentLocation;
  final String? errorMessage;
  final Marker? marker;

  final int selectedEvent;
  final DateTime? eventDate;
  final String? eventTime;

  final List<PlaceModel>? searchResults;
  final PlaceModel? selectedSearchResult;
  final bool showSearchResults;

  EventFormState({
    this.createEventRequestState = RequestState.init,
    this.updateEventRequestState = RequestState.init,
    this.deleteEventRequestState = RequestState.init,
    this.setPositionRequestState = RequestState.init,
    this.searchRequestState = RequestState.init,
    this.currentPosition,
    this.currentLocation,
    this.errorMessage,
    this.marker,
    this.selectedEvent = 1,
    this.eventDate,
    this.eventTime,
    this.searchResults,
    this.selectedSearchResult,
    this.showSearchResults = false,
  });

  EventFormState copyWith({
    RequestState? createEventRequestState,
    RequestState? updateEventRequestState,
    RequestState? deleteEventRequestState,
    RequestState? setPositionRequestState,
    RequestState? searchRequestState,
    LatLng? currentPosition,
    String? currentLocation,
    String? errorMessage,
    Marker? marker,
    int? selectedEvent,
    DateTime? eventDate,
    String? eventTime,
    List<PlaceModel>? searchResults,
    PlaceModel? selectedSearchResult,
    bool? showSearchResults,
  }) {
    return EventFormState(
      createEventRequestState:
      createEventRequestState ?? this.createEventRequestState,
      updateEventRequestState:
      updateEventRequestState ?? this.updateEventRequestState,
      deleteEventRequestState:
      deleteEventRequestState ?? this.deleteEventRequestState,
      setPositionRequestState:
      setPositionRequestState ?? this.setPositionRequestState,
      searchRequestState: searchRequestState ?? this.searchRequestState,
      currentPosition: currentPosition ?? this.currentPosition,
      currentLocation: currentLocation ?? this.currentLocation,
      errorMessage: errorMessage ?? this.errorMessage,
      marker: marker ?? this.marker,
      selectedEvent: selectedEvent ?? this.selectedEvent,
      eventDate: eventDate ?? this.eventDate,
      eventTime: eventTime ?? this.eventTime,
      searchResults: searchResults ?? this.searchResults,
      selectedSearchResult: selectedSearchResult ?? this.selectedSearchResult,
      showSearchResults: showSearchResults ?? this.showSearchResults,
    );
  }
}

class EventFormInitState extends EventFormState {
  EventFormInitState()
      : super(
    createEventRequestState: RequestState.init,
    updateEventRequestState: RequestState.init,
    deleteEventRequestState: RequestState.init,
    setPositionRequestState: RequestState.init,
    searchRequestState: RequestState.init,
    currentPosition: null,
    currentLocation: null,
    marker: null,
    selectedEvent: 1,
    eventDate: null,
    eventTime: null,
    searchResults: null,
    selectedSearchResult: null,
    showSearchResults: false,
  );
}
