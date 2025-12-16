import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/Core/Models/event_model.dart';
import 'package:evently/Core/Models/user_model.dart';
import 'package:evently/Features/Home%20Screen/persentation/Tabs/Home%20Tab/data/Data%20source/home_tab_ds.dart';
import 'package:evently/Features/Home%20Screen/persentation/Tabs/Home%20Tab/domain/Repository/home_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

}