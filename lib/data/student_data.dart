import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:e2portal/model/model.dart';

class StudentData{
  List<Student> list = [];
  String error;
  StudentData.fromJson(Response response){
    Map<String, dynamic> data = jsonDecode(response.data);
    data.entries.forEach((e) => list.add(Student.fromJson(e.value)));
  }
  StudentData.withError(String error){
    this.error = error;
  }
}