// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../Features/Authentication%20Screens/Data/data%20source/auth_ds.dart'
    as _i276;
import '../../Features/Authentication%20Screens/Data/Repository%20Implementation/repo_impl.dart'
    as _i680;
import '../../Features/Authentication%20Screens/Domain/Repository/repo.dart'
    as _i420;
import '../../Features/Authentication%20Screens/Domain/Usecases/forget%20password%20usecase/forget_password_usecse.dart'
    as _i505;
import '../../Features/Authentication%20Screens/Domain/Usecases/sign%20up%20usecase/signup_usecse.dart'
    as _i775;
import '../../Features/Authentication%20Screens/Domain/Usecases/signin%20usecase/signin_usecse.dart'
    as _i522;
import '../../Features/Authentication%20Screens/Presentation/Screens/Forget%20Password%20Screen/Cubit/forget_password_viewModel.dart'
    as _i580;
import '../../Features/Authentication%20Screens/Presentation/Screens/Login%20Screen/Cubit/login%20view%20model.dart'
    as _i571;
import '../../Features/Authentication%20Screens/Presentation/Screens/Register%20Screen/Cubit/register_view_model.dart'
    as _i977;
import '../../Features/Event%20Management/Data/Data%20source/event_management_ds.dart'
    as _i235;
import '../../Features/Event%20Management/Data/Repository%20implmentation/event_management_repo_imp.dart'
    as _i311;
import '../../Features/Event%20Management/Domain/Repository/event_management_repo.dart'
    as _i341;
import '../../Features/Event%20Management/Domain/Use%20cases/create_event_usecase.dart'
    as _i225;
import '../../Features/Event%20Management/Presentation/Cubit/View%20Models/event_form_view_model.dart'
    as _i821;
import '../../Features/Home%20Screen/data/datasource/home_screen_ds.dart'
    as _i526;
import '../../Features/Home%20Screen/data/Repository%20Implementation/repo_impl.dart'
    as _i534;
import '../../Features/Home%20Screen/domain/Repository/home_screen_repo.dart'
    as _i1038;
import '../../Features/Home%20Screen/domain/Usecase/get_curr_user_usecas.dart'
    as _i43;
import '../../Features/Home%20Screen/domain/Usecase/update_fave.dart' as _i117;
import '../../Features/Home%20Screen/persentation/Tabs/Fav%20Tab/data/Data%20source/fave_ds.dart'
    as _i980;
import '../../Features/Home%20Screen/persentation/Tabs/Fav%20Tab/data/Repository%20IMP/fav_repo_imp.dart'
    as _i597;
import '../../Features/Home%20Screen/persentation/Tabs/Fav%20Tab/domain/Repository/fav_repo.dart'
    as _i183;
import '../../Features/Home%20Screen/persentation/Tabs/Fav%20Tab/domain/Usecase/get_fav_events_usecase.dart'
    as _i218;
import '../../Features/Home%20Screen/persentation/Tabs/Fav%20Tab/domain/Usecase/search_usecase.dart'
    as _i55;
import '../../Features/Home%20Screen/persentation/Tabs/Fav%20Tab/persentation/Cubit/fav_tab_view_model.dart'
    as _i667;
import '../../Features/Home%20Screen/persentation/Tabs/Home%20Tab/data/Data%20source/home_tab_ds.dart'
    as _i3;
import '../../Features/Home%20Screen/persentation/Tabs/Home%20Tab/data/Repository%20IMP/home_rep_impl.dart'
    as _i993;
import '../../Features/Home%20Screen/persentation/Tabs/Home%20Tab/domain/Repository/home_repo.dart'
    as _i153;
import '../../Features/Home%20Screen/persentation/Tabs/Home%20Tab/domain/Usecase/get_events_usecase.dart'
    as _i868;
import '../../Features/Home%20Screen/persentation/Tabs/Home%20Tab/persentation/Cubit/home_tab_view_model.dart'
    as _i351;
import '../../Features/Home%20Screen/persentation/Tabs/Map%20Tab/data/Data%20source/map_tab_ds.dart'
    as _i214;
import '../../Features/Home%20Screen/persentation/Tabs/Map%20Tab/data/Repository%20IMP/map_tab_repo_imp.dart'
    as _i599;
import '../../Features/Home%20Screen/persentation/Tabs/Map%20Tab/domain/Repository/mab_tap_repo.dart'
    as _i865;
import '../../Features/Home%20Screen/persentation/Tabs/Map%20Tab/domain/Usecase/get_all_events_use_case.dart'
    as _i1004;
import '../../Features/Home%20Screen/persentation/Tabs/Map%20Tab/persentation/Cubit/map_tab_view_model.dart'
    as _i60;
import '../../Features/Home%20Screen/persentation/Tabs/Profile%20Tab/data/Data%20source/local_ds.dart'
    as _i736;
import '../../Features/Home%20Screen/persentation/Tabs/Profile%20Tab/data/Data%20source/remote_ds.dart'
    as _i998;
import '../../Features/Home%20Screen/persentation/Tabs/Profile%20Tab/data/Repository%20IMP/local_repo_imp.dart'
    as _i873;
import '../../Features/Home%20Screen/persentation/Tabs/Profile%20Tab/data/Repository%20IMP/remote_repo_imp.dart'
    as _i121;
import '../../Features/Home%20Screen/persentation/Tabs/Profile%20Tab/domain/Repository/local_repo.dart'
    as _i1022;
import '../../Features/Home%20Screen/persentation/Tabs/Profile%20Tab/domain/Repository/remote_repo.dart'
    as _i334;
import '../../Features/Home%20Screen/persentation/Tabs/Profile%20Tab/domain/Usecase/logout_usecase.dart'
    as _i894;
import '../../Features/Home%20Screen/persentation/Tabs/Profile%20Tab/domain/Usecase/upload_image_usecase.dart'
    as _i538;
import '../../Features/Home%20Screen/persentation/Tabs/Profile%20Tab/persentation/Cubit/profile_view_model.dart'
    as _i911;
import '../../Features/Onboarding%20Screen/data/Repository%20Implementation/onboarding_repo_implementation.dart'
    as _i902;
import '../../Features/Onboarding%20Screen/Domain/Repository/onboarding_repo.dart'
    as _i832;
import '../../Features/Onboarding%20Screen/Domain/Use%20cases/set_intro_seen_use_case.dart'
    as _i980;
import '../../Features/Onboarding%20Screen/Presentation/View%20Model/view_model.dart'
    as _i428;
import '../Common/Data/Data%20source/common_local_data_source.dart' as _i691;
import '../Common/Data/Repository%20Implementation/common_repo_implementation.dart'
    as _i198;
import '../Common/Domain/Repository/common_repo.dart' as _i836;
import '../Common/Domain/Usecases/get_address_usecase.dart' as _i670;
import '../Common/Domain/Usecases/get_curr_langlat_usecase.dart' as _i102;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i736.ProfileLocalDs>(() => _i736.ProfileLocalDsImp());
    gh.factory<_i691.CommonLocalDS>(() => _i691.SharedLocalDSIMP());
    gh.factory<_i998.ProfileRemoteDs>(() => _i998.ProfileRemoteDsImp());
    gh.factory<_i235.EventManagementDS>(() => _i235.EventManagementDSImp());
    gh.factory<_i1022.ProfileLocalRepo>(
      () => _i873.ProfileLocalRepoImp(gh<_i736.ProfileLocalDs>()),
    );
    gh.factory<_i276.AuthDs>(() => _i276.AuthDsImp());
    gh.factory<_i832.OnboardingRepo>(() => _i902.OnboardingRepoImp());
    gh.factory<_i3.HomeTabDS>(() => _i3.HomeTabDSImp());
    gh.factory<_i214.MapTabDs>(() => _i214.MapTabDsImp());
    gh.factory<_i334.ProfileRemoteRepo>(
      () => _i121.ProfileRemoteRepoImp(gh<_i998.ProfileRemoteDs>()),
    );
    gh.factory<_i526.HomeScreenDS>(() => _i526.HomeScreenDSImp());
    gh.factory<_i420.AuthRepo>(
      () => _i680.AuthRepoImpl(ds: gh<_i276.AuthDs>()),
    );
    gh.factory<_i1038.HomeScreenRepo>(
      () => _i534.HomeScreenRepoImp(gh<_i526.HomeScreenDS>()),
    );
    gh.factory<_i865.MapTabRepo>(
      () => _i599.MabTabRepoImp(ds: gh<_i214.MapTabDs>()),
    );
    gh.factory<_i980.FaveTabDS>(() => _i980.FaveTabDSImp());
    gh.factory<_i1004.GetAllEventsUC>(
      () => _i1004.GetAllEventsUC(repo: gh<_i865.MapTabRepo>()),
    );
    gh.factory<_i538.UploadUserImageUC>(
      () => _i538.UploadUserImageUC(
        gh<_i334.ProfileRemoteRepo>(),
        gh<_i1022.ProfileLocalRepo>(),
      ),
    );
    gh.factory<_i894.LogoutUC>(
      () => _i894.LogoutUC(gh<_i334.ProfileRemoteRepo>()),
    );
    gh.factory<_i183.FavRepo>(() => _i597.FavRepoImp(gh<_i980.FaveTabDS>()));
    gh.factory<_i980.SetOnboardingSeenUC>(
      () => _i980.SetOnboardingSeenUC(repo: gh<_i832.OnboardingRepo>()),
    );
    gh.factory<_i836.CommonRepo>(
      () => _i198.SharedRepoIMP(gh<_i691.CommonLocalDS>()),
    );
    gh.factory<_i341.EventManagementRepo>(
      () => _i311.EventManagementRepoImp(gh<_i235.EventManagementDS>()),
    );
    gh.factory<_i153.HomeRepo>(() => _i993.HomeRepoImp(gh<_i3.HomeTabDS>()));
    gh.factory<_i43.GetCurrUserUC>(
      () => _i43.GetCurrUserUC(gh<_i1038.HomeScreenRepo>()),
    );
    gh.factory<_i117.UpdateFavUC>(
      () => _i117.UpdateFavUC(gh<_i1038.HomeScreenRepo>()),
    );
    gh.factory<_i225.CreateEventUC>(
      () => _i225.CreateEventUC(gh<_i341.EventManagementRepo>()),
    );
    gh.factory<_i218.GetFavEventsUC>(
      () => _i218.GetFavEventsUC(gh<_i183.FavRepo>()),
    );
    gh.factory<_i55.SearchUC>(() => _i55.SearchUC(gh<_i183.FavRepo>()));
    gh.factory<_i505.ForgetPassUC>(
      () => _i505.ForgetPassUC(gh<_i420.AuthRepo>()),
    );
    gh.factory<_i775.SignupUC>(() => _i775.SignupUC(gh<_i420.AuthRepo>()));
    gh.factory<_i522.SignInUC>(() => _i522.SignInUC(gh<_i420.AuthRepo>()));
    gh.factory<_i667.FavViewModel>(
      () => _i667.FavViewModel(
        searchUseCase: gh<_i55.SearchUC>(),
        favEventsUseCase: gh<_i218.GetFavEventsUC>(),
        updateUseCase: gh<_i117.UpdateFavUC>(),
      ),
    );
    gh.factory<_i670.SetEventLocationUC>(
      () => _i670.SetEventLocationUC(gh<_i836.CommonRepo>()),
    );
    gh.factory<_i102.GetCurrentPositionUseCase>(
      () => _i102.GetCurrentPositionUseCase(gh<_i836.CommonRepo>()),
    );
    gh.factory<_i911.ProfileViewModel>(
      () => _i911.ProfileViewModel(
        uploadUC: gh<_i538.UploadUserImageUC>(),
        getCurrUserUC: gh<_i43.GetCurrUserUC>(),
        logoutUC: gh<_i894.LogoutUC>(),
      ),
    );
    gh.factory<_i428.OnboardingViewModel>(
      () => _i428.OnboardingViewModel(useCase: gh<_i980.SetOnboardingSeenUC>()),
    );
    gh.factory<_i60.MapTabViewModel>(
      () => _i60.MapTabViewModel(
        gh<_i1004.GetAllEventsUC>(),
        gh<_i670.SetEventLocationUC>(),
        gh<_i102.GetCurrentPositionUseCase>(),
      ),
    );
    gh.factory<_i868.GetEventsUC>(
      () => _i868.GetEventsUC(gh<_i153.HomeRepo>()),
    );
    gh.factory<_i571.LoginViewModel>(
      () => _i571.LoginViewModel(gh<_i522.SignInUC>()),
    );
    gh.factory<_i977.RegisterViewModel>(
      () => _i977.RegisterViewModel(gh<_i775.SignupUC>()),
    );
    gh.factory<_i580.ForgetPasswordViewModel>(
      () => _i580.ForgetPasswordViewModel(gh<_i505.ForgetPassUC>()),
    );
    gh.factory<_i821.EventFormViewModel>(
      () => _i821.EventFormViewModel(
        createUseCase: gh<_i225.CreateEventUC>(),
        positionUseCase: gh<_i102.GetCurrentPositionUseCase>(),
        locationUseCase: gh<_i670.SetEventLocationUC>(),
      ),
    );
    gh.factory<_i351.HomeTabViewModel>(
      () => _i351.HomeTabViewModel(
        userUseCase: gh<_i43.GetCurrUserUC>(),
        eventsUseCase: gh<_i868.GetEventsUC>(),
        favUseCase: gh<_i117.UpdateFavUC>(),
      ),
    );
    return this;
  }
}
