import 'dart:collection';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:e2portal/model/timetable/timetable.dart';

class TimeTableData {
  List<TimeTable> list = [];
  int statusCode;
  String error;
  TimeTableData.fromResponse(Response response) {
    this.statusCode = response.statusCode;
    Map<String, dynamic> data = jsonDecode(response.data);
    Map<String, dynamic> _embedded = data['_embedded'];
    List timetableList = _embedded['timetable'];
    timetableList.forEach((element) {
      TimeTable timeTable = TimeTable.fromJson(element);
      list.add(timeTable);
    });
  }

  TimeTableData.withError(String error) {
    this.error = error;
  }
}