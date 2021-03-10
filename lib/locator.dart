import 'package:get_it/get_it.dart';
import 'package:iremember/services/database_service.dart';
import 'package:iremember/services/file_service.dart';
import 'package:iremember/viewmodels/base_model.dart';
import 'package:iremember/viewmodels/create_item_view_model.dart';
import 'package:iremember/viewmodels/home_view_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => FileService());
  locator
      .registerLazySingleton(() => FirebaseDataProvider());

  locator.registerFactory(() => HomeModel());
  locator.registerFactory(() => CreateItemModel());
}
