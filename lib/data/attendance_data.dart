import 'package:e2portal/model/model.dart';

class AttendanceData{
  final ModuleClass moduleClass;
  final List<Attendance> listAttendance;
  final Map<String, double> dataMap;

  AttendanceData({this.moduleClass, this.listAttendance, this.dataMap,});

}