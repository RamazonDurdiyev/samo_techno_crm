// import 'dart:async';
// import 'dart:convert';
// import 'package:dio/dio.dart';
// import 'package:get_it/get_it.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';
// import 'package:samo_techno_crm/models/login_data/login_data.dart';
// import 'package:samo_techno_crm/repo/login_repo/login_repo.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// Dio addInterceptor(Dio dio) {
//   final tokenHelper = GetIt.instance.get<RefreshTokenHelper>();

//   dio.interceptors.add(PrettyDioLogger(
//     request: true,
//     requestBody: true,
//     requestHeader: true,
//     responseHeader: true,
//   ));
//   dio.interceptors.add(
//     InterceptorsWrapper(
//       onRequest: (options, handler) {
//         final token = tokenHelper.getToken();
//         print("Network interceptor addInterceptor token => $token");
//         if (token != null) {
//           options.headers['Authorization'] = "Bearer $token";
//           // options.headers['Accept'] = "Application/json";
//           return handler.next(options);
//         }
//         return handler.next(options);
//       },
//       onError: (e, handler) async {
//         if (e.response?.statusCode == 413) {
//           print("NetworkInterceptor need to refresh token");
//           final isTokenRefreshed = await tokenHelper.updateToken().future;
//           if (isTokenRefreshed) {
//             try {
//               final res = await _retry(e.requestOptions);
//               return handler.resolve(
//                 res,
//               );
//             } catch (error) {
//               handler.next(e);
//             }
//           } else {
//             return handler.next(e);
//           }
//         }
//         return handler.next(e);
//       },
//     ),
//   );
//   return dio;
// }

// _retry(RequestOptions requestOptions) {
//   final client = Dio();
//   print("NetworkInterceptor _retry function called");

//   final options = Options(
//     method: requestOptions.method,
//     headers: requestOptions.headers,
//   );
//   return client.request(
//     requestOptions.path,
//     data: requestOptions.data,
//     queryParameters: requestOptions.queryParameters,
//     options: options,
//   );
// }

// class RefreshTokenHelper {
//   final requests = <Completer<bool>>[];
//   final SharedPreferences prefs;
//   bool isRefreshing = false;

//   RefreshTokenHelper({required this.prefs});

//   Completer<bool> updateToken() {
//     final completer = Completer<bool>();
//     requests.add(completer);
//     if (!isRefreshing) {
//       isRefreshing = true;
//       print("Token helper _updateToken called");
//       _updateToken();
//     }
//     return completer;
//   }

//   Future<bool> _updateToken() async {
//     final LoginRepo loginRepo = GetIt.instance.get<LoginRepo>();

//     try {
//       final lastToken = getToken(true);
//       final newToken = await loginRepo.refresh(lastToken ?? "");
//       final prefs = await SharedPreferences.getInstance();
//       prefs.setString("user", json.encode(newToken.toJson()));

//       print("_updateToken refresh completed in NetworkInterceptor");
//       completeRefresh(true);
//       return true;
//     } catch (e) {
//       print("_updateToken refresh error NetworkInterceptor => $e");
//       completeRefresh(false);
//       return false;
//     }
//   }

//   void completeRefresh(bool isRefreshed) {
//     isRefreshing = false;
//     for (var element in requests) {
//       element.complete(isRefreshed);
//     }
//     requests.clear();
//   }

//   String? getToken([bool isRefresh = false]) {
//     final prefs = GetIt.instance.get<SharedPreferences>();
//     final loginData = prefs.getString("user");
//     print("$loginData get token function loginData");
//     if (loginData?.isNotEmpty == true) {
//       print("getToken LoginData is not empty");
//       return isRefresh
//           ? LoginData.fromJson(json.decode(loginData ?? "")).refreshToken
//           : LoginData.fromJson(json.decode(loginData ?? "")).accessToken;
//     }
//     return null;
//   }
// }

import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:samo_techno_crm/models/login_data/login_data.dart';
import 'package:samo_techno_crm/repo/login_repo/login_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

Dio addInterceptor(Dio dio) {
  final tokenHelper = GetIt.instance.get<RefreshTokenHelper>();

  dio.interceptors.add(PrettyDioLogger(
    request: true,
    requestBody: true,
    requestHeader: true,
    responseHeader: true,
  ));
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      final token = tokenHelper.getToken();
      print("addInterceptor initial getToken accessToken => $token");
      if (token != null) {
        options.headers['Authorization'] = "Bearer $token";
        return handler.next(options);
      }
      return handler.next(options);
    },
    onError: (e, handler) async {
      print(
          "${e.requestOptions.path} =================================================================================");
      if (e.response?.statusCode == 413) {
        final isTokenRefreshed = await tokenHelper.updateToken().future;
        if (isTokenRefreshed) {
          try {
            final res = await _retry(e.requestOptions);
            return handler.resolve(
              res,
            );
          } catch (error) {
            handler.next(e);
          }
        } else {
          return handler.next(e);
        }
      }
      return handler.next(e);
    },
  ));
  return dio;
}

_retry(RequestOptions requestOptions) {
  print("_retry function called !!!!!!!!!!!");
  final client = GetIt.instance.get<Dio>();

  final options = Options(
    method: requestOptions.method,
    headers: requestOptions.headers,
  );
  return client.request(
    requestOptions.path,
    data: requestOptions.data,
    queryParameters: requestOptions.queryParameters,
    options: options,
  );
}

class RefreshTokenHelper {
  final requests = <Completer<bool>>[];
  final SharedPreferences prefs;
  bool isRefreshing = false;

  RefreshTokenHelper({required this.prefs});

  Completer<bool> updateToken() {
    final completer = Completer<bool>();
    requests.add(completer);
    if (!isRefreshing) {
      isRefreshing = true;
      _updateToken();
    }
    return completer;
  }

  Future<bool> _updateToken() async {
    final LoginRepo loginRepo = GetIt.instance.get<LoginRepo>();
    print("_updateToken function called @@@@@@@@@@@@@@@@@");
    try {
      final lastToken = getToken(true);
      print("getToken refreshToken => $lastToken");
      final newToken = await loginRepo.refresh(lastToken ?? "");
      prefs.setString("user", json.encode(newToken.toJson())).then((value) =>
          print("setString to Shared after update token to new token $value"));
      completeRefresh(true);
      return true;
    } catch (e) {
      completeRefresh(false);
      return false;
    }
  }

  void completeRefresh(bool isRefreshed) {
    isRefreshing = false;
    for (var element in requests) {
      element.complete(isRefreshed);
    }
    requests.clear();
  }

  String? getToken([bool isRefresh = false]) {
    final box = GetIt.instance.get<SharedPreferences>();
    final loginData = box.getString("user");
    print("LoginData isNotEmpty = ${loginData?.isNotEmpty == true && LoginData.fromJson(json.decode(loginData ?? "")).id != null}");
    print("getToken function lastToken => $loginData");
    if (loginData?.isNotEmpty == true &&
        LoginData.fromJson(json.decode(loginData ?? "")).id != null) {
      return isRefresh
          ? LoginData.fromJson(json.decode(loginData ?? "")).refreshToken
          : LoginData.fromJson(json.decode(loginData ?? "")).accessToken;
    }
    return null;
  }
}
