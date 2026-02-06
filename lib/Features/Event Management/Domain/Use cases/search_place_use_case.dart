
import 'package:injectable/injectable.dart';

import '../../../../Core/Models/place_model.dart';
import '../Repository/event_management_repo.dart';
@injectable
class SearchPlaceUC {
  final EventManagementRepo repo;

  SearchPlaceUC({required this.repo});

  Future<List<PlaceModel>?> call(String searchName)  async {
    try{
      List<PlaceModel>? loc= await repo.searchPlace(searchName);
      return loc;
    }catch(e){
      rethrow;
    }
  }
}