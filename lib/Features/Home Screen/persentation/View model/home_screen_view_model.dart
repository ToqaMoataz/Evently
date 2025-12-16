import 'package:bloc/bloc.dart';
import 'package:evently/Features/Home%20Screen/persentation/View%20model/home_screen_states.dart';


class HomeScreenViewModel extends Cubit<HomeScreenState>{
  HomeScreenViewModel() : super(HomeScreenInitState());


  void setCurrTab(int index){
    emit(state.copyWith(currentTabIndex: index));
  }


}