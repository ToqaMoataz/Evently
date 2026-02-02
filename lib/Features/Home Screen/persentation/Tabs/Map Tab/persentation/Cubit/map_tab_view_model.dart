import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:evently/Features/Home%20Screen/persentation/Tabs/Map%20Tab/domain/Usecase/get_all_events_use_case.dart';
import 'package:evently/Features/Home%20Screen/persentation/Tabs/Map%20Tab/persentation/Cubit/map_tab_states.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../Core/Common/Domain/Usecases/get_address_usecase.dart';
import '../../../../../../../Core/Common/Domain/Usecases/get_curr_langlat_usecase.dart';
import '../../../../../../../Core/Models/event_model.dart';
import '../../../../../../../Core/assets/const data.dart';

@injectable
class MapTabViewModel extends Cubit<MapTabState>{
  MapTabViewModel(this.eventsUseCase,this.locationUseCase,this.positionUseCase) : super( MapTabInitState());
  final GetCurrentPositionUseCase positionUseCase;
  final GetLocationUC locationUseCase;
  final GetAllEventsUC eventsUseCase;
  StreamSubscription<List<EventModel>>? _eventSub;

  void setMarker(LatLng position){

    final marker = Marker(
      markerId:MarkerId('event_location'),
      position: position,
      infoWindow: const InfoWindow(
        title: 'Event Location',
      ),
    );
    emit(
      state.copyWith(
        currentEventPosition: position,
        marker: marker,
      ),
    );
  }

  Future<void> getInitialPosition() async {
    emit(state.copyWith(setPositionRequestState: RequestState.loading));
    try {
      LatLng? position = await positionUseCase.call();
      if (position != null) {
        emit(
          state.copyWith(
              setPositionRequestState: RequestState.success,
              currentEventPosition: position,
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(setPositionRequestState: RequestState.error,errorMessage: e.toString()));
    }
  }

  void getEvents() {
    emit(state.copyWith(getUserEventsRequestState: RequestState.loading));

    try {
      _eventSub?.cancel();

      _eventSub = eventsUseCase.call()?.listen(
            (events) {
          if (isClosed) return;
          emit(state.copyWith(
            getUserEventsRequestState: RequestState.success,
            events: events,
          ));
        },
        onError: (e) {
          if (isClosed) return;
          emit(state.copyWith(
            getUserEventsRequestState: RequestState.error,
            errorMessage: e.toString(),
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        getUserEventsRequestState: RequestState.error,
        errorMessage: e.toString(),
      ));
    }
  }


}