import '../Repository/event_management_repo.dart';

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



