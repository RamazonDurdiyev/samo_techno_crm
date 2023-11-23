import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:samo_techno_crm/repo/product_repo/product_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/app_const/app_const.dart';
import 'core/network/network_info.dart';
import 'core/network/network_interceptor.dart';
import 'repo/login_repo/login_repo.dart';

// Dependency injection file

final sl = GetIt.instance;

Future<void> init() async {
  final prefs = await SharedPreferences.getInstance();
  final user = prefs.getString("user") ?? "";

  var dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(
        milliseconds: CONNECT_TIME_OUT,
      ),
      receiveTimeout: const Duration(
        milliseconds: RECEIVE_TIME_OUT,
      ),
      sendTimeout: const Duration(
        milliseconds: SEND_TIME_OUT,
      ),
    ),
  );

  // External
  sl.registerLazySingleton<SharedPreferences>(() => prefs);
  sl.registerLazySingleton<String>(() => user);
  sl.registerSingleton<RefreshTokenHelper>(RefreshTokenHelper(prefs: prefs));
  dio = addInterceptor(dio);
  sl.registerLazySingleton(() => dio);
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      connectivity: sl(),
      dataChecker: sl(),
    ),
  );

  // core
  // sl.registerLazySingleton(() => InputConverter());

  // Repositories
  sl.registerLazySingleton(
    () => LoginRepo(
      networkInfo: sl.get(),
      client: sl.get(),
      prefs: prefs,
    ),
  );

  sl.registerLazySingleton(
    () => ProductRepo(
      networkInfo: sl.get(),
      client: sl.get(),
    ),
  );

  // sl.registerLazySingleton(
  //   () => ProductRepo(
  //     client: sl.get(),
  //     networkInfo: sl.get(),
  //   ),
  // );

  // sl.registerLazySingleton(
  //   () => BannerRepo(
  //     networkInfo: sl.get(),
  //     client: dio,
  //   ),
  // );

  // sl.registerLazySingleton(
  //   () => CategoryRepo(
  //     networkInfo: sl.get(),
  //     client: dio,
  //   ),
  // );

  // sl.registerLazySingleton(
  //   () => ComplexRepo(
  //     networkInfo: sl.get(),
  //     localDb: sl.get(),
  //     client: dio,
  //   ),
  // );

  // sl.registerLazySingleton(
  //   () => RegionDistrictRepo(
  //     client: sl.get(),
  //     networkInfo: sl.get(),
  //   ),
  // );
}
