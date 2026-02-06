import 'package:bloc/bloc.dart';
import 'package:evently/Features/Event%20Management/Domain/Use%20cases/delete_event_usecase.dart';
import 'package:evently/Features/Event%20Management/Domain/Use%20cases/update_event_usecase.dart';
import 'package:flutter/material.dart';

import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

import '../../../../../Core/Common/Domain/Usecases/get_address_usecase.dart';
import '../../../../../Core/Common/Domain/Usecases/get_curr_langlat_usecase.dart';
import '../../../../../Core/Models/event_model.dart';
import '../../../../../Core/Models/place_model.dart';
import '../../../../../Core/assets/const data.dart';

import '../../../Domain/Use cases/create_event_usecase.dart';
import '../../../Domain/Use cases/search_place_use_case.dart';
import '../States/event_form_states.dart';

@injectable
class EventFormViewModel extends Cubit<EventFormState> {
  EventFormViewModel(
    this._createUseCase,
    this._positionUseCase,
    this._locationUseCase,
    this._deleteUseCase,
    this._updateUseCase,
    this._getLocationUseCase,
  ) : super(EventFormInitState());

  final CreateEventUC _createUseCase;
  final GetCurrentPositionUseCase _positionUseCase;
  final GetLocationUC _locationUseCase;
  final DeleteEventUC _deleteUseCase;
  final UpdateEventUC _updateUseCase;
  final SearchPlaceUC _getLocationUseCase;

  void resetState() {
    emit(EventFormInitState());
  }

  void _setMarker(LatLng position) {
    final marker = Marker(
      markerId: MarkerId('current'),
      position: position,
      infoWindow: const InfoWindow(title: 'Event Location'),
    );

    emit(state.copyWith(marker: marker));
  }

  void setEventDate(DateTime selectedDate) {
    emit(state.copyWith(eventDate: selectedDate));
  }

  void setEventTime(String selectedTime) {
    emit(state.copyWith(eventTime: selectedTime));
  }

  void selectEventCategory(int index) {
    emit(state.copyWith(selectedEvent: index));
  }

  void loadEvent(EventModel event) {
    setCurrentPosition(event.eventPosition);
    setIndexWithCategory(event.eventCategory);
    emit(
      state.copyWith(
        eventDate: DateTime.fromMillisecondsSinceEpoch(event.date * 1000),
        eventTime: event.time,
      ),
    );
  }

  void setIndexWithCategory(String eventCategory) {
    int index = AppData.events.indexOf(eventCategory);
    selectEventCategory(index);
  }

  Future<void> setCurrentPosition(LatLng position) async {
    emit(state.copyWith(setPositionRequestState: RequestState.loading));
    try {
      String? location = await _locationUseCase.call(position);
      _setMarker(position);
      emit(
        state.copyWith(
          setPositionRequestState: RequestState.success,
          currentPosition: position,
          currentLocation: location,
          marker: Marker(markerId: MarkerId("current"), position: position),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          setPositionRequestState: RequestState.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> getInitialPosition() async {
    emit(state.copyWith(setPositionRequestState: RequestState.loading));
    try {
      LatLng? position = await _positionUseCase.call();
      if (position != null) {
        String? location = await _locationUseCase.call(position);
        _setMarker(position);
        emit(
          state.copyWith(
            setPositionRequestState: RequestState.success,
            currentPosition: position,
            currentLocation: location,
            marker: Marker(markerId: MarkerId("current"), position: position),
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          setPositionRequestState: RequestState.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void selectPlace(PlaceModel selectedLocation) {
    emit(state.copyWith(showSearchResults: false));
    try {
      LatLng newPosition = LatLng(
        selectedLocation.latLng.latitude,
        selectedLocation.latLng.longitude,
      );
      setCurrentPosition(newPosition);
      emit(state.copyWith(selectedSearchResult: selectedLocation));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  void unShowResultsCard() {
    emit(state.copyWith(showSearchResults: false));
  }

  Future<void> searchPlace(String place) async {
    print("i ammmmmmmm INVOKEddddddDDDDDDDDD");
    emit(state.copyWith(searchRequestState: RequestState.loading));
    try {
      List<PlaceModel>? places = await _getLocationUseCase.call(place);

      emit(
        state.copyWith(
          searchRequestState: RequestState.success,
          searchResults: places,
          showSearchResults: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          searchRequestState: RequestState.error,
        ),
      );
    }
  }

  Future<void> createEvent(EventModel model) async {
    emit(state.copyWith(createEventRequestState: RequestState.loading));
    try {
      await _createUseCase.call(model);
      emit(state.copyWith(createEventRequestState: RequestState.success));
    } catch (e) {
      emit(
        state.copyWith(
          createEventRequestState: RequestState.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> deleteEvent(String id) async {
    emit(state.copyWith(deleteEventRequestState: RequestState.loading));
    try {
      await _deleteUseCase.call(id);
      emit(state.copyWith(deleteEventRequestState: RequestState.success));
    } catch (e) {
      emit(
        state.copyWith(
          deleteEventRequestState: RequestState.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> updateEvent(EventModel model) async {
    emit(state.copyWith(updateEventRequestState: RequestState.loading));
    print("STATE: ${state.updateEventRequestState}");

    try {
      await _updateUseCase.call(model);
      emit(state.copyWith(updateEventRequestState: RequestState.success));
      print("STATE: ${state.updateEventRequestState}");
    } catch (e) {
      emit(
        state.copyWith(
          updateEventRequestState: RequestState.error,
          errorMessage: e.toString(),
        ),
      );
      print(
        "STATE: ${state.updateEventRequestState} , ERROR:${state.errorMessage} ",
      );
    }
  }
}
