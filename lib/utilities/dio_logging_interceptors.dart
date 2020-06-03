import 'package:dio/dio.dart';
import 'package:e2portal/data/shared_preferences_manager.dart';
import 'package:e2portal/injector/injector.dart';
class DioLoggingInterceptors extends InterceptorsWrapper {
  final Dio _dio;
  final SharedPreferencesManager _sharedPreferencesManager = locator<SharedPreferencesManager>();

  DioLoggingInterceptors(this._dio);

  @override
  Future onRequest(RequestOptions options) async {
    options.headers.forEach((key, value) => {print('$key : $value')});
    if (options.data != null) {
      print("Body :${options.data}");
    }
    print("END ${options.method != null ? options.method.toUpperCase() : 'METHOD'}");
    if (options.headers.containsKey('requirestoken') && (_sharedPreferencesManager.getString(SharedPreferencesManager.accessToken) != null)) {
      options.headers.remove('requirestoken');
      String accessToken = _sharedPreferencesManager.getString(SharedPreferencesManager.accessToken);
      options.headers.addAll({'Authorization': 'Bearer $accessToken'});
      print("Token header :$accessToken");
      print(options.headers);
    }
    return options;
  }

  @override
  Future onResponse(Response response) {
    print(
        "<< ${response.statusCode} ${(response.request != null ? (response.request.baseUrl + response.request.path) : 'URL')}");
    print("Headers : ");
    response.headers?.forEach((name, values) => print("$name : $values"));
    print("Response: ${response.data}");
    print("END HTTP");
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) async {
    print("[Error]");
    print(err.error);
//    print(err.message);
    return super.onError(err);
  }
}
