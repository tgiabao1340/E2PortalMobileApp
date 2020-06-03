import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:e2portal/data/announcements_data.dart';
import 'package:e2portal/data/shared_preferences_manager.dart';
import 'package:e2portal/data/timetable_data.dart';
import 'package:e2portal/injector/injector.dart';
import 'package:e2portal/model/announcement/announcement.dart';
import 'package:e2portal/model/grading_result/grading_result.dart';
import 'package:e2portal/model/lecturer.dart';
import 'package:e2portal/model/model.dart';
import 'package:e2portal/utilities/dio_logging_interceptors.dart';
import 'package:flutter/cupertino.dart';
import 'package:global_configuration/global_configuration.dart';

class ApiProfileProvider {
  final Dio _dio = new Dio();

  ApiProfileProvider() {
    String baseUrl = GlobalConfiguration().getString('apiUrl');
    _dio.options.baseUrl = baseUrl;
    _dio.interceptors.add(DioLoggingInterceptors(_dio));
  }
  Future<Student> getStudent() async {
    try {
      final response = await _dio.get('/user/profile', options: Options(headers: {'requiresToken': true}));
      if(response.statusCode == 401){
        return Student.withError(error: 'Mã sinh viên hoặc mật khẩu không đúng');
      }
      return Student.fromJson(response.data);
    }catch(_error, stacktrace) {
      if(_error is DioError) return Student.withError(error: _handleDioError(_error).toString());
      return Student.withError(error: "Mã sinh viên hoặc mật khẩu không đúng");
    }
  }
  Future<AnnouncementsData> getAnnouncements(int page) async {
    try {
      final response = await _dio.get('/announcements/?page=$page&size=10&sort=createdDate,DESC', options: Options(headers: {'requiresToken': true}));
      return AnnouncementsData.fromResponse(response);
    }catch(_error) {
      if(_error is IOException){
        return AnnouncementsData.withError("Connection Error!");
      }else{
        print(_error.toString());
        return AnnouncementsData.withError("Something went wrong.");
      }
    }
  }
  Future<TimeTableData> getTimeTable(String moduleClassId) async {
    try {
      final response = await _dio.get('/module_class/$moduleClassId/timeTables', options: Options(headers: {'requiresToken': true}));
      return TimeTableData.fromResponse(response);
    }catch(_error) {
      if(_error is IOException){
        return TimeTableData.withError("Connection Error!");
      }else{
        print(_error.toString());
        return TimeTableData.withError("Something went wrong.");
      }
    }
  }
  Future<Lecturer> getMainClassLecturer(String mainClassId) async{
    try {
      final response = await _dio.get('/main_class/$mainClassId/lecturer', options: Options(headers: {'requiresToken': true}));
      return Lecturer.fromJson(jsonDecode(response.data));
    }catch(_error, stacktrace) {
      print(_error.toString());
      return null;
    }
  }
  Future<Lecturer> getLecturerByModuleClass(String moduleClassId) async{
    try {
      final response = await _dio.get('/module_class/$moduleClassId/lecturer', options: Options(headers: {'requiresToken': true}));
      return Lecturer.fromJson(jsonDecode(response.data));
    }catch(_error, stacktrace) {
      return null;
    }
  }
  Future<int> getTotalDay(String moduleClassId) async {
    try {
      final response = await _dio.get('/module_class/$moduleClassId/totalDay', options: Options(headers: {'requiresToken': true}));
      return response.data;
    }catch(_error) {
      return 0;
    }
  }
  String _handleDioError(DioError error) {
    String errorDesc = "";
      switch (error.type) {
        case DioErrorType.CANCEL:
          errorDesc = "Request canceled!";
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          errorDesc = "Connect timeout!";
          break;
        case DioErrorType.DEFAULT:
          errorDesc = "Connection failed!";
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          errorDesc = "Receive timeout!";
          break;
        case DioErrorType.RESPONSE:
          int statusCode = error.response.statusCode;
          if(statusCode == 401){
            errorDesc = "Session timeout";
            break;
          }
          if(statusCode == 404){
            errorDesc = "User not found!";
            break;
          }
          errorDesc = "$statusCode";
          break;
        case DioErrorType.SEND_TIMEOUT:
          errorDesc = "Send timeout!";
          break;
        default:
          errorDesc = "Unexpected error occured!";
      }
    return errorDesc;
  }

  void _printError(error, StackTrace stacktrace) {
    debugPrint('error: $error');
  }
}
