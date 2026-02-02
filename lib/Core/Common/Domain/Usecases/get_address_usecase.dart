
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

import '../Repository/common_repo.dart';

@injectable
class GetLocationUC {
  final CommonRepo repo;
  GetLocationUC(this.repo);

  Future<String?> call(LatLng position) async {
    try {
      Placemark? placemark= await repo.getUserLocation(position);
      String? location="${placemark?.locality}, ${placemark?.country}";
      return location;
    } catch (e) {
      rethrow;
    }
  }
}
