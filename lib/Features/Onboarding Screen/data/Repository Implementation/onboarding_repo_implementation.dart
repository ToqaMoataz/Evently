
import 'package:injectable/injectable.dart';

import '../../../../Core/Shared Prefrences/shared_pref.dart';
import '../../Domain/Repository/onboarding_repo.dart';

@Injectable(as: OnboardingRepo)
class OnboardingRepoImp extends OnboardingRepo{
  @override
  Future<void> setOnboardingSeen() async {
    try{
      await PreferencesHelper.setOnboardingSeen();
    }catch(e){rethrow;}
  }

}