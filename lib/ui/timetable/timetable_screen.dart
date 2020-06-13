import 'dart:collection';

import 'package:e2portal/api/repository/api_profile_repository.dart';
import 'package:e2portal/app_config.dart';
import 'package:e2portal/data/class_time_data.dart';
import 'package:e2portal/data/timetable_data.dart';
import 'package:e2portal/model/model.dart';
import 'package:e2portal/model/timetable/timetable.dart';
import 'package:e2portal/utilities/widgets/card/card_timetable_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeTableScreen extends StatefulWidget {
  final List<ModuleClass> moduleClasses;

  const TimeTableScreen({@required this.moduleClasses});

  @override
  State<StatefulWidget> createState() {
    return new _TimeTableState();
  }
}

class _TimeTableState extends State<TimeTableScreen> {
  ApiProfileRepository _apiProfileRepository = ApiProfileRepository();
  List<TimeTableData> list = [];
  LinkedHashMap<int, List<TimeTable>> _linkedTimetable = LinkedHashMap();
  List<TimeTable> listTimetable = [];
  List currentWeek;
  DateTime currentDateTime;

  ScrollController listController = ScrollController();

  _initListTimetable() {
    widget.moduleClasses.forEach((m) async {
      _apiProfileRepository.getTimeTable(m.moduleClassId).then((value) {
        //Handling error
        if (value.error != null) return;
        if (value.statusCode != 200) return;
        value.list.forEach((element) {
          int key = _convertCharToNum(element.dayOfWeek);
          if (_linkedTimetable.containsKey(key)) {
            _linkedTimetable[key].add(element);
          } else {
            List<TimeTable> list = [element];
            _linkedTimetable.putIfAbsent(key, () => list);
          }
        });
      });
    });
  }

  List<DateTime> calculateDate(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(startDate.add(Duration(days: i)));
    }
    return days;
  }

  _buildListWeek() {
    currentWeek = [];
    DateTime startDate = currentDateTime.subtract(new Duration(days: currentDateTime.weekday - 1));
    DateTime endDate = currentDateTime.add(new Duration(days: DateTime.daysPerWeek - currentDateTime.weekday));
    for (var value in calculateDate(startDate, endDate)) {
      currentWeek.add(value);
    }
  }

  String _convertDateToString(DateTime dateTime) {
    final format = new DateFormat('dd/MM');
    return format.format(dateTime);
  }

  String _weekDay(DateTime dateTime) {
    DateTime startDate = dateTime.subtract(new Duration(days: dateTime.weekday - 1));
    DateTime endDate = dateTime.add(new Duration(days: DateTime.daysPerWeek - dateTime.weekday));
    String firstAndLastDayOfWeek = startDate.day.toString() +
        "/" +
        startDate.month.toString() +
        " - " +
        endDate.day.toString() +
        "/" +
        endDate.month.toString();
    return firstAndLastDayOfWeek;
  }

  List<ClassTimeData> _buildClassTime(int dayOfWeek, DateTime dateTime) {
    List<ClassTimeData> list = [];
    List<TimeTable> listTime = _linkedTimetable[dayOfWeek];
    if (listTime == null) return list;
    listTime.forEach((timetable) {
      //print(timetable.moduleClassId);
      if (dateTime.isBefore(timetable.formatedEndDate) && dateTime.isAfter(timetable.formatedStartDate)) {
        widget.moduleClasses.forEach((m) {
          if (m.moduleClassId == timetable.moduleClassId) {
            ClassTimeData classTimeData = ClassTimeData(moduleClass: m, timeTable: timetable);
            list.add(classTimeData);
          }
        }
        );
      }
    });
    return list;
  }

  int isToday(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day).difference(DateTime(now.year, now.month, now.day)).inDays;
  }

  int _convertCharToNum(String day) {
    switch (day) {
      case "Thứ hai":
        return 1;
      case "Thứ ba":
        return 2;
      case "Thứ tư":
        return 3;
      case "Thứ năm":
        return 4;
      case "Thứ sáu":
        return 5;
      case "Thứ bảy":
        return 6;
      case "Chủ nhật":
        return 7;
      default:
        return 0;
    }
  }

  String _covertNumToWeekDay(int day) {
    switch (day) {
      case 1:
        return "Thứ hai";
      case 2:
        return "Thứ ba";
      case 3:
        return "Thứ tư";
      case 4:
        return "Thứ năm";
      case 5:
        return "Thứ sáu";
      case 6:
        return "Thứ bảy";
      case 7:
        return "Chủ nhật";
      default:
        return "Unknown";
    }
  }

  @override
  void initState() {
    super.initState();
    currentDateTime = DateTime.now();
    setState(() {
      _initListTimetable();
      _buildListWeek();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thời khóa biểu"),
        backgroundColor: AppTheme.HEADLINE,
      ),
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Card(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: Row(
                  children: [
                    Flexible(
                      child: SizedBox(
                        width: double.maxFinite,
                        height: double.maxFinite,
                        child: FlatButton(
                          child: Icon(Icons.arrow_back),
                          onPressed: () {
                            setState(() {
                              DateTime newCurrentTime = currentDateTime.subtract(Duration(days: DateTime.daysPerWeek));
                              currentDateTime = newCurrentTime;
                              _buildListWeek();
                            });
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      child: FittedBox(
                        child: Text(
                          _weekDay(currentDateTime),
                          style: AppTheme.BigTextStyle,
                        ),
                      ),
                    ),
                    Flexible(
                      child: SizedBox(
                        width: double.maxFinite,
                        height: double.maxFinite,
                        child: FlatButton(
                          child: Icon(Icons.arrow_forward),
                          onPressed: () {
                            setState(() {
                              DateTime newCurrentTime = currentDateTime.add(Duration(days: DateTime.daysPerWeek));
                              currentDateTime = newCurrentTime;
                              _buildListWeek();
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            flex: 5,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return CardTimetableDetail(
                  date: _convertDateToString(currentWeek[index]),
                  dayOfWeek: _covertNumToWeekDay(index + 1),
                  isToday: isToday(currentWeek[index]) == 0 ? true : false,
                  list: _buildClassTime(index + 1, currentWeek[index]),
                );
              },
              itemCount: currentWeek.length,
            ),
          ),
        ],
      ),
    );
  }
}
