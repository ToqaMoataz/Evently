import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

import '../../../../../Core/Common/Domain/Usecases/get_address_usecase.dart';
import '../../../../../Core/Common/Domain/Usecases/get_curr_langlat_usecase.dart';
import '../../../../../Core/Models/event_model.dart';
import '../../../../../Core/assets/const data.dart';

import '../../../Domain/Use cases/create_event_usecase.dart';
import '../States/event_form_states.dart';
@injectable
class EventFormViewModel extends Cubit<EventFormState> {
  EventFormViewModel({
    required this.createUseCase,
    required this.positionUseCase,
    required this.locationUseCase,
  }) : super(EventFormInitState());

  final CreateEventUC createUseCase;
  final GetCurrentPositionUseCase positionUseCase;
  final SetEventLocationUC locationUseCase;

  void _setMarker(LatLng position){
    final marker = Marker(
      markerId:MarkerId('current'),
      position: position,
      infoWindow: const InfoWindow(
        title: 'Event Location',
      ),
    );

    emit(
      state.copyWith(
        marker: marker,
      ),
    );
  }

  void setEventDate(DateTime selectedDate){
    emit(state.copyWith(eventDate: selectedDate));
  }

  void setEventTime(TimeOfDay selectedTime){
    emit(state.copyWith(eventTime: selectedTime));
  }
  void selectEventCategory(int index){
    emit(state.copyWith(selectedEvent: index));
  }
  void setIndexWithCategory(String eventCategory){
    int index=AppData.events.indexOf(eventCategory);
    selectEventCategory(index);
  }
  Future<void> setCurrentPosition(LatLng position) async {
    emit(state.copyWith(setPositionRequestState: RequestState.loading));
    try {
      Placemark? location = await locationUseCase.call(position);
      _setMarker(position);
      emit(
        state.copyWith(
          setPositionRequestState: RequestState.success,
          currentPosition: position,
          currentLocation: "${location?.locality}, ${location?.country}",
          marker: Marker(markerId: MarkerId("current"),position:position )
        ),
      );

    }catch (e) {
      emit(state.copyWith(setPositionRequestState: RequestState.error,errorMessage: e.toString()));
    }
  }

  Future<void> getInitialPosition() async {
    emit(state.copyWith(setPositionRequestState: RequestState.loading));
    try {
      LatLng? position = await positionUseCase.call();
      if (position != null) {
        Placemark? location = await locationUseCase.call(position);
        _setMarker(position);
        emit(
          state.copyWith(
            setPositionRequestState: RequestState.success,
            currentPosition: position,
            currentLocation: "${location?.locality}, ${location?.country}",
            marker: Marker(markerId: MarkerId("current"),position:position )
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(setPositionRequestState: RequestState.error,errorMessage: e.toString()));
      print(e.toString());
    }
  }

  Future<void> createEvent(EventModel model) async {
    emit(state.copyWith(createEventRequestState: RequestState.loading));
    try {
      await createUseCase.call(model);
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
}
