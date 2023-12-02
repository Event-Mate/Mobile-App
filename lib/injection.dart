import 'package:event_mate/application/authentication_bloc/authentication_bloc.dart';
import 'package:event_mate/application/avatar_edit_bloc/avatar_edit_bloc.dart';
import 'package:event_mate/application/birthday_edit_bloc/birthday_edit_bloc.dart';
import 'package:event_mate/application/color_theme_bloc/color_theme_bloc.dart';
import 'package:event_mate/application/email_edit_bloc/email_edit_bloc.dart';
import 'package:event_mate/application/email_registration_bloc/email_registration_bloc.dart';
import 'package:event_mate/application/gender_edit_bloc/gender_edit_bloc.dart';
import 'package:event_mate/application/image_picker_bloc/image_picker_bloc.dart';
import 'package:event_mate/application/my_profile_bloc/my_profile_bloc.dart';
import 'package:event_mate/application/name_edit_bloc/name_edit_bloc.dart';
import 'package:event_mate/application/password_edit_bloc/password_edit_bloc.dart';
import 'package:event_mate/application/splash_bloc/splash_bloc.dart';
import 'package:event_mate/application/username_edit_bloc/username_edit_bloc.dart';
import 'package:event_mate/configuration/sembast_configuration.dart'
    as sembast_conf;
import 'package:event_mate/infrastructure/controller/cache_controller/i_cache_controller.dart';
import 'package:event_mate/infrastructure/controller/cache_controller/shared_preferences_cache_controller.dart';
import 'package:event_mate/infrastructure/facade/i_image_facade.dart';
import 'package:event_mate/infrastructure/facade/image_facade.dart';
import 'package:event_mate/infrastructure/repository/i_registration_repository.dart';
import 'package:event_mate/infrastructure/repository/registration_repository.dart';
import 'package:event_mate/infrastructure/storage/user_information_storage/i_user_information_storage.dart';
import 'package:event_mate/infrastructure/storage/user_information_storage/user_information_storage.dart';
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

  final sembastDb = await sembast_conf.openDatabase();
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
  // TODO(Furkan): Uncomment this when user information storage is ready
/*   final userInformationStoreRef =
      sembast_conf.getStoreRef(UserInformationStorage.storeKey);

  getIt.registerSingleton<IUserInformationStorage>(
    UserInformationStorage(
      getIt<sembast.Database>(),
      userInformationStoreRef,
    ),
  ); */

  return true;
}

Future<bool> _injectFacades() async {
  getIt.registerSingleton<IRegistrationRepository>(
    RegistrationRepository(getIt<CustomHttpClient>()),
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
    () => MyProfileBloc(getIt<IUserInformationStorage>()),
  );
  getIt.registerFactory<ColorThemeBloc>(
    () => ColorThemeBloc(getIt<ICacheController>()),
  );

  return true;
}
