import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/Features/Home%20Screen/domain/Repository/home_screen_repo.dart';

class UpdateFavUC{
  UpdateFavUC(this.repo);
  HomeScreenRepo repo;
  Future<void> call(String eventId, bool currentValue)async {
    try {
      await repo.toggleFavorite(eventId, currentValue);
    } on FirebaseException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}