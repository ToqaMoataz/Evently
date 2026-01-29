import 'package:evently/Features/Home%20Screen/persentation/Tabs/Profile%20Tab/domain/Repository/remote_repo.dart';
import 'package:injectable/injectable.dart';
@injectable
class LogoutUC{
  LogoutUC(this.repo);
  ProfileRemoteRepo repo;

  Future<void> call() async {
    try {
      await repo.logout();
    } catch (e) {
      rethrow;
    }
  }
}