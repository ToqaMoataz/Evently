import 'package:evently/Features/Home%20Screen/persentation/Tabs/Fav%20Tab/domain/Repository/fav_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../Core/Models/event_model.dart';
@injectable
class GetFavEventsUC{
  GetFavEventsUC(this.repo);

  FavRepo repo;

  Stream<List<EventModel>> call() {
    try {
      return repo.getFavEvents().map((snapshot) {
        final events = snapshot.docs.map((e) => e.data()).toList();
        return events;
      });
    } catch (e) {
      rethrow;
    }
  }

}