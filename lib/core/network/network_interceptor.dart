import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:samo_techno_crm/models/login_data/login_data.dart';
import 'package:samo_techno_crm/repo/login_repo/login_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

Dio addInterceptor(Dio dio) {
  final tokenHelper = RefreshTokenHelper();

  dio.interceptors.add(PrettyDioLogger(
    request: true,
    requestBody: true,
    requestHeader: true,
    responseHeader: true,
  ));
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      final token = tokenHelper.getToken();
      if (token != null) {
        options.headers['Authorization'] = "Bearer $token";
        options.headers['Accept'] = "Application/json";
        return handler.next(options);
      }
      return handler.next(options);
    },
    onError: (e, handler) async {
      if (e.response?.statusCode == 413 &&
        e.requestOptions.path.contains("login")) {
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
  final client = Dio();

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
  bool isRefreshing = false;

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
    final LoginRepo loginRepo = LoginRepo();

    try {
      final lastToken = getToken(true);
      final newToken = await loginRepo.refresh(lastToken ?? "");
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("new_token",json.encode(newToken));
      
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

   getToken([bool isRefresh = false]) async{
    final prefs = await SharedPreferences.getInstance();
    

    final loginData = prefs.getString("new_token");
    if (loginData?.isNotEmpty == true) {
      return isRefresh ? LoginData.fromJson(json.decode(loginData ?? "")).refreshToken : LoginData.fromJson(json.decode(loginData ?? "")).accessToken;
    }
    return null;
  }
}
