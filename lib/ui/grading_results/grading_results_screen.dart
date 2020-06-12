import 'dart:collection';

import 'package:e2portal/api/repository/api_profile_repository.dart';
import 'package:e2portal/model/grading_result/grading_result.dart';
import 'package:e2portal/model/model.dart';
import 'package:e2portal/router.dart';
import 'package:flutter/material.dart';
import '../../app_config.dart';

class GradingResultScreen extends StatefulWidget {
  final Student student;

  GradingResultScreen({@required this.student});

  @override
  State<StatefulWidget> createState() {
    return new _GradingResultState();
  }
}

class _GradingResultState extends State<GradingResultScreen> {
  ApiProfileRepository apiProfileRepository = new ApiProfileRepository();
  LinkedHashMap<String, List<ModuleClass>> listBySemester = new LinkedHashMap();
  LinkedHashMap<String, GradingResult> listGradingResult = new LinkedHashMap();

  _addToListModule() {
    List<ModuleClass> listModuleClass = widget.student.moduleClasses;
    listModuleClass.forEach((m) {
      if (!listBySemester.containsKey(m.semester)) {
        List<ModuleClass> list = [m];
        listBySemester.putIfAbsent(m.semester, () => list);
      } else {
        listBySemester[m.semester].add(m);
      }
    });
  }

  _addToListGrading() {
    List<GradingResult> list = widget.student.gradingResults;
    list.forEach((g) {
      listGradingResult.putIfAbsent(g.moduleClassId, () => g);
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _addToListModule();
      _addToListGrading();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kết quả học tập"),
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
                        child: Text(
                          key,
                          style: AppTheme.TextCardInfo,
                        ),
                      ),
                    ),
                    onPressed: () {
                      Map args = new Map();
                      args.putIfAbsent("semester", () => key);
                      args.putIfAbsent("list", () => listBySemester[key]);
                      args.putIfAbsent("gradingResult", () => listGradingResult);
                      Navigator.pushNamed(context, gradingDetailRoute, arguments: args);
                    },
                  ),
                  Divider(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
