
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

import '../Repository/event_management_repo.dart';


@injectable
class SetEventLocationUC {
  final EventManagementRepo repo;
  SetEventLocationUC(this.repo);

  Future<Placemark?> call(LatLng position) async {
    try {
      return await repo.getUserLocation(position);
    } catch (e) {
      rethrow;
    }
  }
}
