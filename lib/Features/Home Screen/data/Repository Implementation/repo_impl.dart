import 'package:evently/Core/Models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding_platform_interface/src/models/placemark.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';

import '../../domain/Repository/home_screen_repo.dart';
import '../datasource/home_screen_ds.dart';

class HomeScreenRepoImp extends HomeScreenRepo{
  HomeScreenDS ds;
  HomeScreenRepoImp(this.ds);
  @override
  Future<UserModel?> getCurrUser() async {
    try{
      UserModel? user= await ds.getCurrUser();
      return user;
    }on FirebaseAuthException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> toggleFavorite(String eventId, bool currentValue) async {
    try {
      await ds.toggleFavorite(eventId, currentValue);
    } on FirebaseException catch (e) {
      rethrow ;
    } catch (e) {
      rethrow;
    }
  }



}