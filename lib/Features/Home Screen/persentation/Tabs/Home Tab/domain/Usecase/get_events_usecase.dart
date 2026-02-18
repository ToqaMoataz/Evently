import 'package:evently/Core/Models/event_model.dart';
import 'package:evently/Features/Home Screen/persentation/Tabs/Home Tab/domain/Repository/home_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetEventsUC {
  final HomeRepo repo;

  GetEventsUC(this.repo);

  Future<List<EventModel>>? call(String category,bool isConnected) {
    try {
      return repo.getUserEvents(category,isConnected);
    } catch (e) {
      rethrow;
    }
  }
}
