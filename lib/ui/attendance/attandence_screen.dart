import 'dart:collection';

import 'package:e2portal/model/model.dart';
import 'package:e2portal/router.dart';
import 'package:flutter/material.dart';
import '../../app_config.dart';

class AttendanceScreen extends StatefulWidget {
  final Student student;
  const AttendanceScreen({@required this.student});
  @override
  State<StatefulWidget> createState() {
    return new _AttendanceState();
  }
}

class _AttendanceState extends State<AttendanceScreen> {
  LinkedHashMap<String, List<ModuleClass>> listBySemester = new LinkedHashMap();
  LinkedHashMap<String, List<Attendance>> listAttendance = new LinkedHashMap();
  _addToListModule(){
    List<ModuleClass> listModuleClass = widget.student.moduleClasses;
    listModuleClass.forEach((m) {
      if(!listBySemester.containsKey(m.semester)){
        List<ModuleClass> list = [m];
        listBySemester.putIfAbsent(m.semester, () => list);
      }else {
        listBySemester[m.semester].add(m);
      }
    });
  }
  _addToListAttendance(){
    List<Attendance> list = widget.student.attendances;
    list.forEach((a){
      if(listAttendance.containsKey(a.moduleClassId)){
        listAttendance[a.moduleClassId].add(a);
      }else{
        List<Attendance> list = [a];
        listAttendance.putIfAbsent(a.moduleClassId, () => list);
      }
    });
  }
  @override
  void initState() {
    super.initState();
    _addToListModule();
    _addToListAttendance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Điểm danh"),
        backgroundColor: AppTheme.HEADLINE,
      ),
      body: Container(
          padding: EdgeInsets.all(15),
          child: Center(
            child: ListView.builder(
              itemCount: listBySemester.length,
              itemBuilder: (context, index) {
                String key = listBySemester.keys.elementAt(index);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                      padding: EdgeInsets.all(15),
                      child: Container(
                        height: 50,
                        child: Center(
                          child: Text(key, style: AppTheme.TextCardInfo,),
                        ),
                      ),
                      onPressed: ()  {
                        Map args = new Map();
                        args.putIfAbsent("semester", () => key);
                        args.putIfAbsent("list", () => listBySemester[key]);
                        args.putIfAbsent("attendances", () => listAttendance);
                        Navigator.pushNamed(context, attendanceDetailRoute, arguments: args);
                      },
                    ),
                    Divider(),
                  ],
                );
              },
            ),
          )),
    );
  }
}
