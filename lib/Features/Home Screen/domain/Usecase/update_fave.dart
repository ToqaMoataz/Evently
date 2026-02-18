import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/Features/Home%20Screen/domain/Repository/home_screen_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateFavUC{
  UpdateFavUC(this.repo);
  HomeScreenRepo repo;
  Future<void> call(String eventId, bool currentValue,bool isConnected)async {
    try {
      await repo.toggleFavorite(eventId, currentValue, isConnected:isConnected);
    } on FirebaseException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}