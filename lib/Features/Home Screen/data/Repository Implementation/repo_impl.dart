import 'package:evently/Core/Models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import '../../domain/Repository/home_screen_repo.dart';
import '../datasource/home_screen_ds.dart';

@Injectable(as: HomeScreenRepo)
class HomeScreenRepoImp extends HomeScreenRepo {
  final HomeScreenDS remoteDS;
  final HomeScreenDS localDS;

  HomeScreenRepoImp(
      @Named("remote") this.remoteDS,
      @Named("local") this.localDS,
      );

  HomeScreenDS _getDS(bool isConnected) => isConnected ? remoteDS : localDS;

  @override
  Future<UserModel?> getCurrUser({required bool isConnected}) async {
    try {
      return await _getDS(isConnected).getCurrUser();
    } on FirebaseAuthException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> toggleFavorite(String eventId, bool currentValue, {required bool isConnected}) async {
    try {
      await _getDS(isConnected).toggleFavorite(eventId, currentValue);
    } on FirebaseException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
