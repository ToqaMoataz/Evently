import 'package:injectable/injectable.dart';

import '../Repository/event_management_repo.dart';
@injectable
class DeleteEventUC {
  final EventManagementRepo repo;

  DeleteEventUC(this.repo);

  Future<void> call(String eventId) async {
    try{
      await repo.deleteEvent(eventId);
    }catch(e){
      rethrow;
    }
  }
}



