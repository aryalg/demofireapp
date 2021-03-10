import 'package:get_it/get_it.dart';
import 'package:iremember/services/database_service.dart';
import 'package:iremember/services/file_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => FileService());
  locator
      .registerLazySingleton(() => FirebaseDataProvider());
}
