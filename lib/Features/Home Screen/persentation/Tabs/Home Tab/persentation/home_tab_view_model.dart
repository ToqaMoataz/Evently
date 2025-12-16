import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../../Core/Models/event_model.dart';
import '../../../../../../Core/assets/const data.dart';
import '../../../../domain/Usecase/get_curr_user_usecas.dart';
import '../../../../domain/Usecase/update_fave.dart';
import '../domain/Usecase/get_events_usecase.dart';
import 'home_tab_states.dart';

class HomeTabViewModel extends Cubit<HomeTabState> {
  HomeTabViewModel({
    required this.userUseCase,
    required this.eventsUseCase,
    required this.favUseCase,
  }) : super(HomeTabInitState());

  final GetCurrUserUC userUseCase;
  final GetEventsUC eventsUseCase;
  final UpdateFavUC favUseCase;

  StreamSubscription<List<EventModel>>? _eventSub;

  void getEvents(String category) {
    emit(state.copyWith(getEventsRequestState: RequestState.loading));

    try {
      _eventSub?.cancel();

      _eventSub = eventsUseCase.call(category).listen(
            (events) {
          if (isClosed) return; // ✅ مهم
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

  Future<void> getCurrUser() async {
    emit(state.copyWith(
      getUserInfoRequestState: RequestState.loading,
      errorMessage: null,
    ));

    try {
      final user = await userUseCase.call();

      if (isClosed) return;

      if (user == null) {
        emit(state.copyWith(
          getUserInfoRequestState: RequestState.error,
          errorMessage: 'User not found',
        ));
        return;
      }

      emit(state.copyWith(
        getUserInfoRequestState: RequestState.success,
        currUser: user,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(
        getUserInfoRequestState: RequestState.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void setCurrEvent(int index) {
    if (isClosed) return;
    emit(state.copyWith(categoryIndex: index));
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
