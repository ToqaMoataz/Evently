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

import '../../Features/Event%20Management/Data/Data%20source/event_management_ds.dart'
    as _i235;
import '../../Features/Event%20Management/Data/Repository%20implmentation/event_management_repo_imp.dart'
    as _i311;
import '../../Features/Event%20Management/Domain/Repository/event_management_repo.dart'
    as _i341;
import '../../Features/Event%20Management/Domain/Use%20cases/create_event_usecase.dart'
    as _i225;
import '../../Features/Event%20Management/Domain/Use%20cases/get_address_usecase.dart'
    as _i574;
import '../../Features/Event%20Management/Domain/Use%20cases/get_curr_langlat_usecase.dart'
    as _i822;
import '../../Features/Event%20Management/Presentation/Cubit/View%20Models/event_form_view_model.dart'
    as _i821;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i235.EventManagementDS>(() => _i235.EventManagementDSImp());
    gh.factory<_i341.EventManagementRepo>(
      () => _i311.EventManagementRepoImp(gh<_i235.EventManagementDS>()),
    );
    gh.factory<_i225.CreateEventUC>(
      () => _i225.CreateEventUC(gh<_i341.EventManagementRepo>()),
    );
    gh.factory<_i574.SetEventLocationUC>(
      () => _i574.SetEventLocationUC(gh<_i341.EventManagementRepo>()),
    );
    gh.factory<_i822.GetCurrentPositionUseCase>(
      () => _i822.GetCurrentPositionUseCase(gh<_i341.EventManagementRepo>()),
    );
    gh.factory<_i821.EventFormViewModel>(
      () => _i821.EventFormViewModel(
        createUseCase: gh<_i225.CreateEventUC>(),
        positionUseCase: gh<_i822.GetCurrentPositionUseCase>(),
        locationUseCase: gh<_i574.SetEventLocationUC>(),
      ),
    );
    return this;
  }
}
