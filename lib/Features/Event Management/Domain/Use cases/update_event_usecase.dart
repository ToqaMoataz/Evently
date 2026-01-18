import '../../../../Core/Models/event_model.dart';
import '../Repository/event_management_repo.dart';

class UpdateEventUC {
  final EventManagementRepo repo;

  UpdateEventUC(this.repo);

  Future<void> call(EventModel event) async {
    try{
    await repo.updateEvent(event);
    }catch(e){
      rethrow;
    }
  }
}
