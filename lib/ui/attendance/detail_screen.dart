import 'dart:collection';

import 'package:e2portal/api/repository/api_profile_repository.dart';
import 'package:e2portal/data/attendance_data.dart';
import 'package:e2portal/model/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../app_config.dart';

class AttendanceDetailScreen extends StatefulWidget {
  final List<ModuleClass> listModuleClass;
  final LinkedHashMap<String, List<Attendance>> listAttendance;
  final String semester;

  AttendanceDetailScreen({@required this.listModuleClass, this.semester, this.listAttendance});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AttendanceDetailState();
  }
}

class _AttendanceDetailState extends State<AttendanceDetailScreen> {
  ApiProfileRepository _apiProfileRepository = ApiProfileRepository();
  List<AttendanceData> listData = [];

  _loadChart() {
    widget.listModuleClass.forEach((m) {
      _apiProfileRepository.getTotalDayModuleClass(m.moduleClassId).then((value) {
        if (widget.listAttendance[m.moduleClassId] != null) {
          Map<String, double> dataMap = Map();
          var totalDay = value.toDouble();
          dataMap.putIfAbsent("Nghỉ", () => widget.listAttendance[m.moduleClassId].length.toDouble());
          dataMap.putIfAbsent("Tổng", () => totalDay);
          AttendanceData attendanceData =
              AttendanceData(moduleClass: m, listAttendance: widget.listAttendance[m.moduleClassId], dataMap: dataMap);
          setState(() {
            listData.add(attendanceData);
          });
        } else {
          Map<String, double> dataMap = Map();
          var totalDay = value.toDouble();
          dataMap.putIfAbsent("Nghỉ", () => 0);
          dataMap.putIfAbsent("Tổng", () => totalDay);

          AttendanceData attendanceData = AttendanceData(moduleClass: m, listAttendance: [], dataMap: dataMap);
          setState(() {
            listData.add(attendanceData);
          });
        }
      });
    });
  }

  @override
  void initState() {
    _loadChart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.semester),
        backgroundColor: AppTheme.HEADLINE,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: listData.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                GestureDetector(
                  onTap: () => {
                    showDialog(
                        context: context,
                        builder: (context) => Dialog(
                              child: SingleChildScrollView(
                                child: Container(
                                  padding: EdgeInsets.all(15),
                                  child: Column(
                                    children: [
                                      Text(listData[index].moduleClass.moduleClassName, style: AppTheme.LabelTextStyle,),
                                      Row(
                                        children: [
                                          Text("Tổng buổi học : "),
                                          Text(listData[index].dataMap["Tổng"].toInt().toString())
                                        ],
                                      ),
                                      Divider(),
                                      Row(
                                        children: [
                                          Text("Số buổi vắng : "),
                                          Text(listData[index].dataMap["Nghỉ"].toInt() == -1
                                              ? "0"
                                              : listData[index].dataMap["Nghỉ"].toInt().toString())
                                        ],
                                      ),
                                      SizedBox(
                                        height: 400,
                                        child: GridView.count(
                                          childAspectRatio: 6 / 2,
                                          crossAxisCount: 2,
                                          children: List.generate(listData[index].listAttendance.length, (r) {
                                            Attendance attendance = listData[index].listAttendance[r];
                                            return Card(
                                              elevation: 8.0,
                                                color: attendance.allowed ? Colors.green : Colors.redAccent,
                                                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                                child: Center(
                                                  child: Text(attendance.formattedDateOff),
                                                )
                                            );
                                          }),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ))
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: Row(
                      children: [
                        Container(
                            width: 150,
                            child: Center(
                              child: PieChart(
                                dataMap: listData[index].dataMap,
                                animationDuration: Duration(milliseconds: 800),
                                chartLegendSpacing: 32.0,
                                chartRadius: MediaQuery.of(context).size.width / 2.7,
                                showChartValuesInPercentage: true,
                                showChartValues: false,
                                showChartValuesOutside: false,
                                chartValueBackgroundColor: Colors.grey[200],
                                showLegends: false,
                                legendPosition: LegendPosition.right,
                                decimalPlaces: 1,
                                showChartValueLabel: false,
                                initialAngle: 0,
                                chartValueStyle: defaultChartValueStyle.copyWith(
                                  color: Colors.blueGrey[900].withOpacity(0.9),
                                ),
                                chartType: ChartType.disc,
                              ),
                            )),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(15),
                            alignment: Alignment.center,
                            child: Column(children: [
                              Text(
                                listData[index].moduleClass.moduleClassId,
                                style: AppTheme.TextCardLabel,
                              ),
                              Text(
                                listData[index].moduleClass.moduleClassName,
                                style: AppTheme.TextCardInfo,
                              ),
                              Divider(),
                              Row(
                                children: [
                                  Text("Tổng buổi học : "),
                                  Text(listData[index].dataMap["Tổng"].toInt().toString())
                                ],
                              ),
                              Divider(),
                              Row(
                                children: [
                                  Text("Số buổi vắng : "),
                                  Text(listData[index].dataMap["Nghỉ"].toInt() == -1
                                      ? "0"
                                      : listData[index].dataMap["Nghỉ"].toInt().toString())
                                ],
                              )
                            ]),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Divider(),
              ],
            );
          },
        ),
      ),
    );
  }
}
