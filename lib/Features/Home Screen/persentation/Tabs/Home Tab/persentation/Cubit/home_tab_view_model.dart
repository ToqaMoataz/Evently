import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/Core/Common/Domain/Usecases/get_address_usecase.dart';
import 'package:evently/Core/Common/Domain/Usecases/get_curr_langlat_usecase.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../Core/Models/event_model.dart';
import '../../../../../../../Core/assets/const data.dart';
import '../../../../../domain/Usecase/get_curr_user_usecas.dart';
import '../../../../../domain/Usecase/update_fave.dart';
import '../../domain/Usecase/get_events_usecase.dart';
import 'home_tab_states.dart';

@injectable
class HomeTabViewModel extends Cubit<HomeTabState> {
  HomeTabViewModel({

    required this.eventsUseCase,
    required this.favUseCase,
    required this.getLocationUseCase,
    required this.getPositionUseCase
  }) : super(HomeTabInitState());


  final GetEventsUC eventsUseCase;
  final UpdateFavUC favUseCase;
  final GetCurrentPositionUseCase getPositionUseCase;
  final GetLocationUC getLocationUseCase;

  StreamSubscription<List<EventModel>>? _eventSub;

  void getEvents(String category) {
    emit(state.copyWith(getEventsRequestState: RequestState.loading));

    try {
      _eventSub?.cancel();

      _eventSub = eventsUseCase.call(category)?.listen(
            (events) {
          if (isClosed) return;
          emit(state.copyWith(
            getEventsRequestState: RequestState.success,
            events: events,
          ));
        },
        onError: (e) {
          if (isClosed) return;
          emit(state.copyWith(
            getEventsRequestState: RequestState.error,
            errorMessage: e.toString(),
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        getEventsRequestState: RequestState.error,
        errorMessage: e.toString(),
      ));
    }
  }


  void setCurrEvent(int index) {
    if (isClosed) return;
    emit(state.copyWith(categoryIndex: index));
  }

  Future<void> getUserLocation()async {
    try{
      LatLng? currPosition=await getPositionUseCase.call();
      if(currPosition!=null){
        String? currLocation=await getLocationUseCase.call(currPosition);
        emit(state.copyWith(userLocation: currLocation));
      }
    }catch(e){
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> updateFave(String eventId, bool currentValue) async {
    emit(state.copyWith(toggleEventFavRequestState: RequestState.loading));
    try {
      await favUseCase.call(eventId, currentValue);
      if (isClosed) return;
      emit(state.copyWith(toggleEventFavRequestState: RequestState.success));
    } on FirebaseException catch (e) {
      if (isClosed) return;
      emit(state.copyWith(
        toggleEventFavRequestState: RequestState.error,
        errorMessage: e.message,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(
        toggleEventFavRequestState: RequestState.error,
        errorMessage: e.toString(),
      ));
    }
  }

  @override
  Future<void> close() {
    _eventSub?.cancel();
    return super.close();
  }
}
