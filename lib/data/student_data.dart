import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:e2portal/model/model.dart';

class StudentData{
  List<Student> list = [];
  String error;
  StudentData.fromJson(Response response){
    List listData = response.data;
    listData.forEach((f){
      Student student = Student.fromJson(f);
      list.add(student);
    });
  }
  StudentData.withError(String error){
    this.error = error;
  }
}