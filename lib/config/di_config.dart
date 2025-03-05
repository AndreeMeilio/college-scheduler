

import 'package:college_scheduler/config/database.dart';
import 'package:college_scheduler/data/local_data/event_local_data.dart';
import 'package:college_scheduler/data/local_data/users_local_data.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.I;

void setupServiceLocator(){
  sl.registerLazySingleton<DatabaseConfig>(() => DatabaseConfig());
  sl.registerLazySingleton<UsersLocalData>(() => UsersLocalData(database: sl()));
  sl.registerLazySingleton(() => EventLocalData(database: sl()));
}