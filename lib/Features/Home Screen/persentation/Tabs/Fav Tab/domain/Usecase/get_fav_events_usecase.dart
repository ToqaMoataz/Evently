import 'package:evently/Features/Home%20Screen/persentation/Tabs/Fav%20Tab/domain/Repository/fav_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../Core/Models/event_model.dart';
@injectable
class GetFavEventsUC {
  final FavRepo repo;
  GetFavEventsUC(this.repo);

  Stream<List<EventModel>> call(bool isConnected) async* {
    try {
      final events = await repo.getFavEvents(isConnected);
      yield events;
    } catch (e) {
      rethrow;
    }
  }
}