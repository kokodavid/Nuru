// ignore: import_of_legacy_library_into_null_safe
import 'package:get_it/get_it.dart';
import 'package:nuru/repository/storage_repo.dart';
import 'package:nuru/helpers/user_controller.dart';

import '../repository/auth_repo.dart';




final locator = GetIt.instance;

void setupServices() {
  locator.registerSingleton<AuthRepo>(AuthRepo());
  locator.registerSingleton<StorageRepo>(StorageRepo());
  // locator.registerSingleton<AuthenticationService>(AuthenticationService());
  locator.registerSingleton<UserController>(UserController());
}
