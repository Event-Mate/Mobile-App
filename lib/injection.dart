import 'package:event_mate/application/authentication_bloc/authentication_bloc.dart';
import 'package:event_mate/application/avatar_edit_bloc/avatar_edit_bloc.dart';
import 'package:event_mate/application/birthday_edit_bloc/birthday_edit_bloc.dart';
import 'package:event_mate/application/bottom_navbar_bloc/bottom_navbar_bloc.dart';
import 'package:event_mate/application/color_theme_bloc/color_theme_bloc.dart';
import 'package:event_mate/application/email_edit_bloc/email_edit_bloc.dart';
import 'package:event_mate/application/email_login_bloc/email_login_bloc.dart';
import 'package:event_mate/application/email_registration_bloc/email_registration_bloc.dart';
import 'package:event_mate/application/event_fetcher_bloc/event_fetcher_bloc.dart';
import 'package:event_mate/application/gender_edit_bloc/gender_edit_bloc.dart';
import 'package:event_mate/application/image_picker_bloc/image_picker_bloc.dart';
import 'package:event_mate/application/interests_edit_bloc/interests_edit_bloc.dart';
import 'package:event_mate/application/my_profile_bloc/my_profile_bloc.dart';
import 'package:event_mate/application/name_edit_bloc/name_edit_bloc.dart';
import 'package:event_mate/application/password_edit_bloc/password_edit_bloc.dart';
import 'package:event_mate/application/splash_bloc/splash_bloc.dart';
import 'package:event_mate/application/username_edit_bloc/username_edit_bloc.dart';
import 'package:event_mate/configuration/sembast_configuration.dart'
    as sembast_config;
import 'package:event_mate/infrastructure/controller/cache_controller/i_cache_controller.dart';
import 'package:event_mate/infrastructure/controller/cache_controller/shared_preferences_cache_controller.dart';
import 'package:event_mate/infrastructure/facade/i_image_facade.dart';
import 'package:event_mate/infrastructure/facade/image_facade.dart';
import 'package:event_mate/infrastructure/repository/event_repository/event_repository.dart';
import 'package:event_mate/infrastructure/repository/event_repository/i_event_repository.dart';
import 'package:event_mate/infrastructure/repository/login_repository/i_login_repository.dart';
import 'package:event_mate/infrastructure/repository/login_repository/login_repository.dart';
import 'package:event_mate/infrastructure/repository/registration_repository/i_registration_repository.dart';
import 'package:event_mate/infrastructure/repository/registration_repository/registration_repository.dart';
import 'package:event_mate/infrastructure/storage/user_data_storage/i_user_data_storage.dart';
import 'package:event_mate/infrastructure/storage/user_data_storage/user_data_storage.dart';
import 'package:event_mate/service/custom_http_client.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
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
  getIt.registerSingleton<ImagePicker>(ImagePicker());

  final sembastDb = await sembast_config.openDatabase();
  if (sembastDb == null) {
    return false;
  } else {
    getIt.registerSingleton<sembast.Database>(sembastDb);
    return true;
  }
}

Future<bool> _injectStorages() async {
  getIt.registerSingleton<ICacheController>(
    SharedPreferencesCacheController(getIt<SharedPreferences>()),
  );

  final userDataStoreRef = sembast_config.getStoreRef(UserDataStorage.storeKey);

  getIt.registerSingleton<IUserDataStorage>(
    UserDataStorage(
      userDataStoreRef,
      getIt<sembast.Database>(),
    ),
  );

  return true;
}

Future<bool> _injectFacades() async {
  getIt.registerSingleton<IRegistrationRepository>(
    RegistrationRepository(getIt<CustomHttpClient>()),
  );
  getIt.registerSingleton<ILoginRepository>(
    LoginRepository(getIt<CustomHttpClient>()),
  );
  getIt.registerSingleton<IEventRepository>(
    EventRepository(getIt<CustomHttpClient>()),
  );
  getIt.registerSingleton<IImageFacade>(
    ImageFacade(getIt<ImagePicker>()),
  );
  return true;
}

Future<bool> _injectBlocs() async {
  getIt.registerFactory<SplashBloc>(
    () => SplashBloc(getIt<ICacheController>()),
  );
  getIt.registerFactory<AuthenticationBloc>(
    () => AuthenticationBloc(
      getIt<ICacheController>(),
      getIt<IUserDataStorage>(),
    ),
  );
  getIt.registerFactory<EmailRegistrationBloc>(
    () => EmailRegistrationBloc(
      getIt<IRegistrationRepository>(),
      getIt<IUserDataStorage>(),
      getIt<ICacheController>(),
    ),
  );
  getIt.registerFactory<EmailLoginBloc>(
    () => EmailLoginBloc(
      getIt<ILoginRepository>(),
      getIt<ICacheController>(),
      getIt<IUserDataStorage>(),
    ),
  );
  getIt.registerFactory<NameEditBloc>(
    // ignore: unnecessary_lambdas
    () => NameEditBloc(),
  );
  getIt.registerFactory<UsernameEditBloc>(
    () => UsernameEditBloc(
      getIt<IRegistrationRepository>(),
    ),
  );
  getIt.registerFactory<EmailEditBloc>(
    () => EmailEditBloc(
      getIt<IRegistrationRepository>(),
    ),
  );
  getIt.registerFactory<PasswordEditBloc>(
    // ignore: unnecessary_lambdas
    () => PasswordEditBloc(),
  );
  getIt.registerFactory<GenderEditBloc>(
    // ignore: unnecessary_lambdas
    () => GenderEditBloc(),
  );
  getIt.registerFactory<BirthdayEditBloc>(
    // ignore: unnecessary_lambdas
    () => BirthdayEditBloc(),
  );
  getIt.registerFactory<AvatarEditBloc>(
    // ignore: unnecessary_lambdas
    () => AvatarEditBloc(),
  );
  getIt.registerFactory<ImagePickerBloc>(
    () => ImagePickerBloc(getIt<IImageFacade>()),
  );
  getIt.registerFactory<MyProfileBloc>(
    () => MyProfileBloc(
      getIt<IUserDataStorage>(),
      getIt<ICacheController>(),
    ),
  );
  getIt.registerFactory<EventFetcherBloc>(
    () => EventFetcherBloc(getIt<IEventRepository>()),
  );
  getIt.registerFactory<ColorThemeBloc>(
    () => ColorThemeBloc(getIt<ICacheController>()),
  );
  getIt.registerFactory<BottomNavbarBloc>(
    // ignore: unnecessary_lambdas
    () => BottomNavbarBloc(),
  );
  getIt.registerFactory<InterestsEditBloc>(
    () => InterestsEditBloc(getIt<IEventRepository>()),
  );

  return true;
}
