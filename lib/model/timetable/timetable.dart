import 'package:intl/intl.dart';

class TimeTable {
  int timeTableId;
  String classRoom;
  String dayOfWeek;
  String period;
  String startDate;
  String endDate;
  String moduleClassId;
  DateTime formatedEndDate;
  DateTime formatedStartDate;

  TimeTable(
      {this.timeTableId,
        this.classRoom,
        this.dayOfWeek,
        this.period,
        this.startDate,
        this.endDate,
        this.moduleClassId,
        this.formatedEndDate,
        this.formatedStartDate,
      });

  TimeTable.fromJson(Map<String, dynamic> json) {
    timeTableId = json['timeTableId'];
    classRoom = json['classRoom'];
    dayOfWeek = json['dayOfWeek'];
    period = json['period'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    moduleClassId = json['moduleClassId'];
    formatedEndDate = DateFormat("dd/MM/yyyy").parse(json['formatedEndDate']);
    formatedStartDate = DateFormat("dd/MM/yyyy").parse(json['formatedStartDate']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timeTableId'] = this.timeTableId;
    data['classRoom'] = this.classRoom;
    data['dayOfWeek'] = this.dayOfWeek;
    data['period'] = this.period;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['moduleClassId'] = this.moduleClassId;
    data['formatedEndDate'] = this.formatedEndDate;
    data['formatedStartDate'] = this.formatedStartDate;
    return data;
  }
}