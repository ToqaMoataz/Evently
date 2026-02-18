import 'package:bloc/bloc.dart';
import 'package:evently/Features/Home%20Screen/persentation/View%20model/home_screen_states.dart';
import 'package:injectable/injectable.dart';

import '../../../../Core/assets/const data.dart';
import '../../domain/Usecase/get_curr_user_usecas.dart';

@injectable
class HomeScreenViewModel extends Cubit<HomeScreenState>{
  HomeScreenViewModel({required this.userUseCase}) : super(HomeScreenInitState());
  final GetCurrUserUC userUseCase;

  void setCurrTab(int index){
    emit(state.copyWith(currentTabIndex: index));
  }

  Future<void> getCurrUser(bool isConnected) async {
    emit(state.copyWith(
      getUserInfoRequestState: RequestState.loading,
    ));

    try {
      final user = await userUseCase.call(isConnected);

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
        currentUser: user
      ));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(
        getUserInfoRequestState: RequestState.error,
        errorMessage: e.toString(),
      ));
    }
  }

}