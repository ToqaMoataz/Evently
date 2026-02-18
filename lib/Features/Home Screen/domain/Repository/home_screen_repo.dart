
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../../../Core/Models/user_model.dart';

abstract class HomeScreenRepo{
  Future<UserModel?> getCurrUser({required bool isConnected});
  Future<void> toggleFavorite(String eventId, bool currentValue, {required bool isConnected});

}