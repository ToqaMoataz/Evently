import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:evently/Features/Home%20Screen/persentation/Tabs/Map%20Tab/persentation/map_tab_states.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../../Core/Models/event_model.dart';
import '../../../../../../Core/assets/const data.dart';
import '../../Home Tab/domain/Usecase/get_events_usecase.dart';

class MapTabViewModel extends Cubit<MapTabState>{
  MapTabViewModel(this.eventsUseCase) : super( MapTabInitState());
  final GetEventsUC eventsUseCase;
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
  void getEvents(String category) {
    emit(state.copyWith(getUserEventsRequestState: RequestState.loading));

    try {
      _eventSub?.cancel();

      _eventSub = eventsUseCase.call(category).listen(
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