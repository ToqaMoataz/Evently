import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/Core/Models/event_model.dart';
import 'package:evently/Features/Home%20Screen/persentation/Tabs/Home%20Tab/data/Data%20source/home_tab_ds.dart';
import 'package:evently/Features/Home%20Screen/persentation/Tabs/Home%20Tab/domain/Repository/home_repo.dart';

class HomeRepoImp extends HomeRepo{
  HomeTabDS ds;
  HomeRepoImp(this.ds);

  @override
  Stream<QuerySnapshot<EventModel>> getUserEvents(String category){
    try{
      Stream<QuerySnapshot<EventModel>> events=ds.getUserEvents(category);
      return events;
    } catch (e) {
      rethrow;
    }
  }

}