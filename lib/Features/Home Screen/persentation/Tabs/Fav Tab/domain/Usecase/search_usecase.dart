
import 'package:evently/Features/Home%20Screen/persentation/Tabs/Fav%20Tab/domain/Repository/fav_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../Core/Models/event_model.dart';
@injectable
class SearchUC {
  final FavRepo repo;
  SearchUC(this.repo);

  Stream<List<EventModel>> call(String subTitle, bool isConnected) async* {
    try {
      final events = await repo.getFavEvents(isConnected);

      final filtered = events
          .where((event) => event.title.toLowerCase().contains(subTitle.toLowerCase()))
          .toList();

      yield filtered;
    } catch (e) {
      rethrow;
    }
  }
}