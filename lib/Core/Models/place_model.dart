import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final LatLng latLng;
  final String name;
  final String osmType;
  final String displayName;

  PlaceModel({
    required this.latLng,
    required this.name,
    required this.osmType,
    required this.displayName,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    final lat = double.tryParse(json['lat'] ?? '0') ?? 0.0;
    final lon = double.tryParse(json['lon'] ?? '0') ?? 0.0;

    return PlaceModel(
      latLng: LatLng(lat, lon),
      name: json['name'] ?? 'Unknown',
      osmType: json['osm_type'],
      displayName: json['display_name'],
    );
  }
}
