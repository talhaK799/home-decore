import 'package:get_it/get_it.dart';
import 'core/services/auth_service.dart';
import 'core/services/database_service.dart';
import 'core/services/notification_service.dart';
import 'core/services/shared_prefs_service.dart';

GetIt locator = GetIt.instance;

setupLocator() {
  locator.registerSingleton(SharedPrefsService());
  locator.registerLazySingleton<DatabaseService>(() => DatabaseService());
  locator.registerSingleton(NotificationsService());
  locator.registerSingleton(AuthService());
}
 