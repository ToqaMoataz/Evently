
import 'package:injectable/injectable.dart';

import '../Repository/onboarding_repo.dart';

@injectable
class SetOnboardingSeenUC {
  OnboardingRepo repo;
  SetOnboardingSeenUC({required this.repo});

  Future<void> call()async {
    try{
      await repo.setOnboardingSeen();
    }catch(e){rethrow;}
  }
}