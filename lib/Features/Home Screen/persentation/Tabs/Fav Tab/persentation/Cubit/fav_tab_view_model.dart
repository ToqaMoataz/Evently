import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../../Core/Models/event_model.dart';
import '../../../../../../../Core/assets/const data.dart';
import '../../../../../domain/Usecase/update_fave.dart';
import '../../domain/Usecase/get_fav_events_usecase.dart';
import '../../domain/Usecase/search_usecase.dart';
import 'fav_tab_states.dart';
@injectable
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



  Future<void> getFavEvents(bool isConnected) async {
    emit(state.copyWith(
      getFavEventsRequestState: RequestState.loading,
    ));

    try {
      final events = await favEventsUseCase.call(isConnected).first;
      if (isClosed) return;

      emit(state.copyWith(
        getFavEventsRequestState: RequestState.success,
        events: events,
      ));

    } catch (e) {
      if (isClosed) return;
      print("Error in getFavEvents: ${e.toString()}");
      emit(state.copyWith(
        getFavEventsRequestState: RequestState.error,
        errorMessage: e.toString(),
      ));
    }
  }


  // ================= SEARCH EVENTS =================

  Future<void> searchEvents(String subTitle,bool isConnected) async {
    emit(state.copyWith(
      searchEventsRequestState: RequestState.loading,
    ));

    try {
      final events = await searchUseCase.call(subTitle,isConnected).first;
      if (isClosed) return;

      emit(state.copyWith(
        searchEventsRequestState: RequestState.success,
        searchResults: events,
      ));

    } catch (e) {
      if (isClosed) return;
      print("Error in searchEvents: ${e.toString()}");
      emit(state.copyWith(
        searchEventsRequestState: RequestState.error,
        errorMessage: e.toString(),
      ));
    }
  }

  // ================= TOGGLE FAVORITE =================

  Future<void> updateFave(String eventId, bool currentValue,bool isConnected) async {
    emit(state.copyWith(
      toggleEventFavRequestState: RequestState.loading,
    ));

    try {
      await updateUseCase.call(eventId, currentValue,isConnected);
      getFavEvents(isConnected);
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
