import 'package:evently/Features/Home%20Screen/persentation/Tabs/Map%20Tab/domain/Repository/mab_tap_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../Core/Models/event_model.dart';

@injectable
class GetAllEventsUC {
  MapTabRepo repo;
  GetAllEventsUC({required this.repo});

  Stream<List<EventModel>>? call() {
    try {
      return repo.getAllUserEvents()?.map((snapshot) {
        final events = snapshot.docs.map((e) => e.data()).toList();
        return events;
      });
    } catch (e) {
      rethrow;
    }
  }
}