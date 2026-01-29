
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import '../Repository/common_repo.dart';
@injectable
class GetCurrentPositionUseCase {
  final CommonRepo repo;

  GetCurrentPositionUseCase(this.repo);

  Future<LatLng?> call() async {
    try {
      return await repo.getCurrentPosition();
    } catch (e) {
      rethrow;
    }
  }
}
