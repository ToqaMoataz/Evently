import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/Core/Models/event_model.dart';
import 'package:evently/Features/Home%20Screen/persentation/Tabs/Map%20Tab/data/Data%20source/map_tab_ds.dart';
import 'package:injectable/injectable.dart';

import '../../domain/Repository/mab_tap_repo.dart';

@Injectable(as: MapTabRepo)
class MabTabRepoImp extends MapTabRepo{
  MabTabRepoImp({required this.ds});
  MapTabDs ds;

  @override
  Stream<QuerySnapshot<EventModel>>? getAllUserEvents() {
    try{
      return ds.getAllUserEvents();
    }catch(e){rethrow;}
  }

}