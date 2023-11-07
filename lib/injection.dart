import 'package:event_mate/application/authentication_bloc/authentication_bloc.dart';
import 'package:event_mate/application/color_theme_bloc/color_theme_bloc.dart';
import 'package:event_mate/application/email_edit_bloc/email_edit_bloc.dart';
import 'package:event_mate/application/email_registration_bloc/email_registration_bloc.dart';
import 'package:event_mate/application/my_profile_bloc/my_profile_bloc.dart';
import 'package:event_mate/application/name_edit_bloc/name_edit_bloc.dart';
import 'package:event_mate/application/splash_bloc/splash_bloc.dart';
import 'package:event_mate/application/username_edit_bloc/username_edit_bloc.dart';
import 'package:event_mate/configuration/sembast_configuration.dart'
    as sembast_conf;
import 'package:event_mate/infrastructure/controller/cache_controller/i_cache_controller.dart';
import 'package:event_mate/infrastructure/controller/cache_controller/shared_preferences_cache_controller.dart';
import 'package:event_mate/infrastructure/repository/i_registration_repository.dart';
import 'package:event_mate/infrastructure/repository/registration_repository.dart';
import 'package:event_mate/infrastructure/storage/user_information_storage/i_user_information_storage.dart';
import 'package:event_mate/infrastructure/storage/user_information_storage/user_information_storage.dart';
import 'package:event_mate/service/http_client.dart';
import 'package:get_it/get_it.dart';
import 'package:sembast/sembast.dart' as sembast;
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<bool> setupInjection() async {
  final isPackageDone = await _injectPackages();
  if (!isPackageDone) return false;

  final isStorageDone = await _injectStorages();
  if (!isStorageDone) return false;

  final isFacadeDone = await _injectFacades();
  if (!isFacadeDone) return false;

  final isBlocDone = await _injectBlocs();
  if (!isBlocDone) return false;

  return true;
}

Future<bool> _injectPackages() async {
  getIt.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );
  getIt.registerSingleton<CustomHttpClient>(CustomHttpClient());

  final sembastDb = await sembast_conf.openDatabase();
  if (sembastDb == null) {
    return false;
  } else {
    getIt.registerSingleton<sembast.Database>(sembastDb);
    return true;
  }
}

Future<bool> _injectStorages() async {
  final userInformationStoreRef =
      sembast_conf.getStoreRef(UserInformationStorage.storeKey);
  getIt.registerSingleton<ICacheController>(
    SharedPreferencesCacheController(getIt<SharedPreferences>()),
  );
  getIt.registerSingleton<IUserInformationStorage>(
    UserInformationStorage(
      getIt<sembast.Database>(),
      userInformationStoreRef,
    ),
  );
  return true;
}

Future<bool> _injectFacades() async {
  getIt.registerSingleton<IRegistrationRepository>(
    RegistrationRepository(getIt<CustomHttpClient>()),
  );
  return true;
}

Future<bool> _injectBlocs() async {
  getIt.registerFactory<SplashBloc>(
    () => SplashBloc(getIt<ICacheController>()),
  );
  getIt.registerFactory<AuthenticationBloc>(
    () => AuthenticationBloc(getIt<ICacheController>()),
  );
  getIt.registerFactory<EmailRegistrationBloc>(
    () => EmailRegistrationBloc(getIt<IRegistrationRepository>()),
  );
  getIt.registerFactory<NameEditBloc>(
    // ignore: unnecessary_lambdas
    () => NameEditBloc(),
  );
  getIt.registerFactory<UsernameEditBloc>(
    // ignore: unnecessary_lambdas
    () => UsernameEditBloc(),
  );
  getIt.registerFactory<EmailEditBloc>(
    // ignore: unnecessary_lambdas
    () => EmailEditBloc(),
  );

  getIt.registerFactory<MyProfileBloc>(
    () => MyProfileBloc(getIt<IUserInformationStorage>()),
  );
  getIt.registerFactory<ColorThemeBloc>(
    () => ColorThemeBloc(getIt<ICacheController>()),
  );

  return true;
}
