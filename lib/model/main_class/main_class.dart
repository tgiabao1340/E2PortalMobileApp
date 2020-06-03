import 'package:e2portal/model/faculty/faculty.dart';

class MainClass {
    String classId;
    String className;
    String speciality;
    String level;
    String type;
    Faculty faculty;
    String year;
    String lecturerId;

    MainClass(
        {this.classId,
            this.className,
            this.speciality,
            this.level,
            this.type,
            this.faculty,
            this.year, this.lecturerId});

    MainClass.fromJson(Map<String, dynamic> json) {
        classId = json['classId'];
        className = json['className'];
        speciality = json['speciality'];
        level = json['level'];
        type = json['type'];
        faculty =
        json['faculty'] != null ? new Faculty.fromJson(json['faculty']) : null;
        year = json['year'];
        lecturerId = json['lecturerId'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['classId'] = this.classId;
        data['className'] = this.className;
        data['speciality'] = this.speciality;
        data['level'] = this.level;
        data['type'] = this.type;
        if (this.faculty != null) {
            data['faculty'] = this.faculty.toJson();
        }
        data['year'] = this.year;
        data['lecturerId'] = this.lecturerId;
        return data;
    }
}