import 'package:evently/Core/Models/event_model.dart';
import 'package:injectable/injectable.dart';

import '../../domain/Repository/fav_repo.dart';
import '../Data source/fave_ds.dart';

@Injectable(as: FavRepo)
class FaveTabRepoImp implements FavRepo {
  final FaveTabDS remote;
  final FaveTabDS local;

  FaveTabRepoImp(@Named("remote") this.remote, @Named("local") this.local);

  @override
  Future<List<EventModel>> getFavEvents(bool isConnected) async {
    if (isConnected) {
      return await remote.getFavEvents();
    } else {
      return await local.getFavEvents();
    }
  }
}
