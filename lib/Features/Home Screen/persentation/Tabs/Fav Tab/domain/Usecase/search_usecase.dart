
import 'package:evently/Features/Home%20Screen/persentation/Tabs/Fav%20Tab/domain/Repository/fav_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../Core/Models/event_model.dart';
@injectable
class SearchUC{
  FavRepo repo;
  SearchUC(this.repo);

  Stream<List<EventModel>> call(String subTitle){
    try {
      return repo.getFavEvents().map((snapshot) {
        return snapshot.docs
            .map((doc) => doc.data())
            .where((event) => event.title.toLowerCase().contains(subTitle.toLowerCase()))
            .toList();
      });
    } catch (e) {
      rethrow;
    }
  }
}