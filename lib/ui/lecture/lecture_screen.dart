import 'dart:collection';

import 'package:e2portal/api/provider/api_profile_provider.dart';
import 'package:e2portal/api/repository/api_profile_repository.dart';
import 'package:e2portal/model/lecturer.dart';
import 'package:e2portal/model/model.dart';
import 'package:e2portal/utilities/widgets/card/card_lecturer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../app_config.dart';

class LectureScreen extends StatefulWidget {
  final Student student;

  LectureScreen({this.student});

  @override
  State<StatefulWidget> createState() {
    print(student.toJson().toString());
    return new _LectureState();
  }
}

class _LectureState extends State<LectureScreen> {
  ApiProfileRepository _apiProfileRepository = ApiProfileRepository();
  LinkedHashMap<String, Lecturer> list = LinkedHashMap();

  _addMainClassLecturer() {
    _apiProfileRepository.getMainClassLecturer(widget.student.mainClass.classId).then((lecturer) {
      if (lecturer != null){
        setState(() {
          list.putIfAbsent(lecturer.id, () => lecturer);
        });
      }

    });
  }

  _addModuleClassLecturer() {
    widget.student.moduleClasses.forEach((m) {
      _apiProfileRepository.getLecturerByModuleClass(m.moduleClassId).then((lecturer) {
        if (lecturer != null) {
          setState(() {
            list.putIfAbsent(lecturer.id, () => lecturer);
          });
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _addMainClassLecturer();
    _addModuleClassLecturer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giảng viên"),
        backgroundColor: AppTheme.HEADLINE,
      ),
      body: Container(
        child: ListView.builder(
          itemCount: list.keys.length,
          itemBuilder: (BuildContext context, int index) {
            Lecturer lecturer = list.values.elementAt(index);
            print(widget.student.mainClass.lecturerId);
            return CardLecturer(lecturer: lecturer, isMainClass: (lecturer.id == widget.student.mainClass.lecturerId));
          },
        ),
      ),
    );
  }
}
