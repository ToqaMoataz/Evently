import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:evently/Core/Models/event_model.dart';
import 'package:evently/Features/Home%20Screen/persentation/Tabs/Fav%20Tab/data/Data%20source/fave_ds.dart';

import '../../domain/Repository/fav_repo.dart';

class FavRepoImp extends FavRepo{
  FaveTabDS ds;
  FavRepoImp(this.ds);
  @override
  Stream<QuerySnapshot<EventModel>> getFavEvents() {
    try {
      return ds.getFavEvents();
    } catch (e) {
      rethrow;
    }
  }

}