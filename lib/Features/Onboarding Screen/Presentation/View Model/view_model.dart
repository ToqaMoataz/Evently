
import 'package:injectable/injectable.dart';

import '../../Domain/Use cases/set_intro_seen_use_case.dart';

@injectable
class OnboardingViewModel {
  SetOnboardingSeenUC useCase;
  OnboardingViewModel({required this.useCase});

  Future<void> setOnboardingSeen() async {
    try{
      await useCase.call();
    }catch(e){
      print(e.toString());
    }
  }
}