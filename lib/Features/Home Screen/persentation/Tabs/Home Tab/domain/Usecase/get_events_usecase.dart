import 'package:evently/Core/Models/event_model.dart';
import 'package:evently/Features/Home Screen/persentation/Tabs/Home Tab/domain/Repository/home_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetEventsUC {
  final HomeRepo repo;

  GetEventsUC(this.repo);

  Stream<List<EventModel>>? call(String category) {
    try {
      return repo.getUserEvents(category)?.map((snapshot) {
        final events = snapshot.docs.map((e) => e.data()).toList();
        return events;
      });
    } catch (e) {
      rethrow;
    }
  }
}
