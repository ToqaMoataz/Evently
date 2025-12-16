
import '../../../../../../../Core/Models/user_model.dart';

abstract class HomeScreenRepo{
  Future<UserModel?> getCurrUser();
  Future<void> toggleFavorite(String eventId, bool currentValue);
}