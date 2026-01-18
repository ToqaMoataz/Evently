import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../../../../../Core/Models/event_model.dart';
import '../../../../../../Core/assets/const data.dart';
import '../../../../domain/Usecase/update_fave.dart';
import '../domain/Usecase/get_fav_events_usecase.dart';
import '../domain/Usecase/search_usecase.dart';
import 'fav_tab_states.dart';

class FavViewModel extends Cubit<FavTabState> {
  final SearchUC searchUseCase;
  final GetFavEventsUC favEventsUseCase;
  final UpdateFavUC updateUseCase;

  FavViewModel({
    required this.searchUseCase,
    required this.favEventsUseCase,
    required this.updateUseCase,
  }) : super(FavTabInitState());

  StreamSubscription<List<EventModel>>? _favEventsSub;
  StreamSubscription<List<EventModel>>? _searchEventsSub;



  void getFavEvents() {
    emit(state.copyWith(
      getFavEventsRequestState: RequestState.loading,
    ));
    _favEventsSub?.cancel();
    _favEventsSub = favEventsUseCase.call().listen(
          (events) {
        if (isClosed) return;
        emit(state.copyWith(
          getFavEventsRequestState: RequestState.success,
          events: events,
        ));
      },
      onError: (e) {
        if (isClosed) return;
        emit(state.copyWith(
          getFavEventsRequestState: RequestState.error,
          errorMessage: e.toString(),
        ));
      },
    );
  }

  // ================= SEARCH EVENTS =================

  void searchEvents(String subTitle) {
    emit(state.copyWith(
      searchEventsRequestState: RequestState.loading,
    ));

    _searchEventsSub?.cancel();
    _searchEventsSub = searchUseCase.call(subTitle).listen(
          (events) {
        if (isClosed) return;
        emit(state.copyWith(
          searchEventsRequestState: RequestState.success,
          searchResults: events,
        ));
      },
      onError: (e) {
        if (isClosed) return;
        emit(state.copyWith(
          searchEventsRequestState: RequestState.error,
          errorMessage: e.toString(),
        ));
      },
    );
  }

  // ================= TOGGLE FAVORITE =================

  Future<void> updateFave(String eventId, bool currentValue) async {
    emit(state.copyWith(
      toggleEventFavRequestState: RequestState.loading,
    ));

    try {
      await updateUseCase.call(eventId, currentValue);
      getFavEvents();
      if (isClosed) return;
      emit(state.copyWith(
        toggleEventFavRequestState: RequestState.success,
      ));
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

  // ================= CLOSE =================

  @override
  Future<void> close() {
    _favEventsSub?.cancel();
    _searchEventsSub?.cancel();
    return super.close();
  }
}
