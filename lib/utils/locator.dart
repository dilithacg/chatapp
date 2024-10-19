import 'package:get_it/get_it.dart';

import '../services/apiservice.dart';


final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => ApiService());
}
