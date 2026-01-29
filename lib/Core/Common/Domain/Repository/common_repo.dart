import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class CommonRepo{
  Future<LatLng?> getCurrentPosition();
  Future<Placemark?> getUserLocation(LatLng position);
}