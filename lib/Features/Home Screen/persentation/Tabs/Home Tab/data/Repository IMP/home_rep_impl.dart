import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/Core/Models/event_model.dart';
import 'package:evently/Features/Home%20Screen/persentation/Tabs/Home%20Tab/data/Data%20source/home_tab_ds.dart';
import 'package:evently/Features/Home%20Screen/persentation/Tabs/Home%20Tab/domain/Repository/home_repo.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: HomeRepo)
class HomeRepoImp implements HomeRepo {
  final HomeTabDS remote;
  final HomeTabDS local;

  HomeRepoImp(@Named("remote") this.remote, @Named("local") this.local,);

  @override
  Future<List<EventModel>> getUserEvents(String category,bool isConnected) async {
    if (isConnected) {
      return await remote.getUserEvents(category);
    } else {
      return await local.getUserEvents(category);
    }
  }
}
