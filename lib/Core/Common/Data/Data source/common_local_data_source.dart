import 'package:geocoding/geocoding.dart' hide Location;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:location/location.dart';

abstract class CommonLocalDS{
  Future<LatLng?> getCurrentPosition();
  Future<Placemark?> getUserLocation(LatLng position);
}

@Injectable(as: CommonLocalDS)
class SharedLocalDSIMP extends CommonLocalDS{
  @override
  Future<Placemark?> getUserLocation(LatLng position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    return placemarks.first;
  }
  @override
  Future<LatLng?> getCurrentPosition() async {
    Location location = Location();
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return null;
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return null;
    }

    final locData = await location.getLocation();
    LatLng? currentPosition=LatLng(locData.latitude!, locData.longitude!);

    return currentPosition;
  }
}