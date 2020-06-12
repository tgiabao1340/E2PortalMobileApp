import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:e2portal/data/shared_preferences_manager.dart';
import 'package:e2portal/injector/injector.dart';
import 'package:e2portal/model/model.dart';
import 'package:e2portal/utilities/dio_logging_interceptors.dart';
import 'package:flutter/cupertino.dart';
import 'package:global_configuration/global_configuration.dart';

class ApiAuthProvider {
  final Dio _dio = new Dio();
  final SharedPreferencesManager _sharedPreferencesManager =
      locator<SharedPreferencesManager>();

  ApiAuthProvider() {
    String baseUrl = GlobalConfiguration().getString('apiUrl');
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = 5000;
    _dio.options.receiveTimeout = 3000;
    _dio.interceptors.add(DioLoggingInterceptors(_dio));
  }

  ///Dang nhap
  Future<Token> loginUser(LoginBody loginBody) async {
    try {
      final response =
          await _dio.post('/authenticate', data: loginBody.toJson());
      return Token.fromJson(response.data);
    } catch (error) {
      return Token.withError(_handleError(error));
    }
  }

  /// Doi mat khau
  Future<bool> changePassword(String newPassword) async {
    try {
      final Map<String, dynamic> payload = new Map<String, dynamic>();
      payload['newPassword'] = newPassword;
      final response = await _dio.post('/change_password',
          data: payload, options: Options(headers: {'requiresToken': true}));
      return response.data;
    } catch (error, stacktrace) {
      _printError(error, stacktrace);
      return false;
    }
  }

  ///Convert Token
  Map<String, dynamic> parseJwt(String token) {
    if (token == null) return null;
    final parts = token.split('.');
    if (parts.length != 3) return null;
    final payload = parts[1];
    var normalized = base64Url.normalize(payload);
    var resp = utf8.decode(base64Url.decode(normalized));
    final payloadMap = json.decode(resp);
    if (payloadMap is! Map<String, dynamic>) return null;
    return payloadMap;
  }

  /// Kiem tra token tren may
  Future<bool> hasToken() async {
    final accessToken = _sharedPreferencesManager
        .getString(SharedPreferencesManager.accessToken);
    Map<String, dynamic> token = parseJwt(accessToken);
    if (token != null) {
      if (token.containsKey("exp")) {
        if (DateTime.fromMillisecondsSinceEpoch(token["exp"] * 1000)
            .isAfter(DateTime.now())) {
          await _sharedPreferencesManager.clearKey(accessToken);
        }
      }
    }
    return _sharedPreferencesManager
                .getString(SharedPreferencesManager.accessToken) !=
            null
        ? true
        : false;
  }

  /// is Parent ?
  Future<bool> isParent() async {
    final isParent = _sharedPreferencesManager
        .getBool(SharedPreferencesManager.isParent);
    return isParent != null ? isParent : false;
  }

  /// Luu token
  Future<void> persistToken(Token token) async {
    Map<String, dynamic> data = parseJwt(token.accessToken);
    if (data != null) {
      if (data.containsKey('sub')) {
        await _sharedPreferencesManager.putString(
            SharedPreferencesManager.id, data['sub'].toString());
      }
    }
    await _sharedPreferencesManager.putString(
        SharedPreferencesManager.accessToken, token.accessToken);
    return;
  }

  ///Xoa token
  Future<void> removeToken() async {
    await _sharedPreferencesManager
        .clearKey(SharedPreferencesManager.accessToken);
    await _sharedPreferencesManager.clearKey(SharedPreferencesManager.id);
    return;
  }

  ///Quan ly loi
  String _handleError(DioError error) {
    String errorDesc = "";
    switch (error.type) {
      case DioErrorType.CANCEL:
        errorDesc = "Request canceled!";
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        errorDesc = "Máy chủ không phản hồi!";
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        errorDesc = "Máy chủ không phản hồi!";
        break;
      case DioErrorType.DEFAULT:
        errorDesc = "Lỗi kết nối!";
        break;

      case DioErrorType.RESPONSE:
        int statusCode = error.response.statusCode;
        if (statusCode == 401 || statusCode == 404) {
          errorDesc = "Tài khoản hoặc mật khẩu không đúng";
          break;
        }
        errorDesc = "$statusCode";
        break;
      case DioErrorType.SEND_TIMEOUT:
        errorDesc = "Send timeout!";
        break;
      default:
        errorDesc = "Lỗi không xác định";
    }

    return errorDesc;
  }

  void _printError(error, StackTrace stacktrace) {
    debugPrint('error: $error');
  }
}
