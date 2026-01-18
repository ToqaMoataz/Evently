import 'package:evently/Core/Models/event_model.dart';
import 'package:injectable/injectable.dart';

import '../Repository/event_management_repo.dart';

@injectable
class CreateEventUC{
  CreateEventUC(this.repo);
  EventManagementRepo repo;

  Future<void> call(EventModel model)async {
    try{
      await repo.addEvent(model);
    }catch(e){rethrow;}
  }
}