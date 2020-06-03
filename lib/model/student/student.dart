import 'package:e2portal/model/attendance/attendance.dart';
import 'package:e2portal/model/grading_result/grading_result.dart';
import 'package:e2portal/model/main_class/main_class.dart';
import 'package:e2portal/model/module_class/module_class.dart';
import 'package:flutter/cupertino.dart';

class Student {
    String id;
    String firstName;
    String lastName;
    bool gender;
    String dateOfBirth;
    String address;
    String numberPhone;
    String email;
    Null imageProfile;
    String familyNumber;
    MainClass mainClass;
    List<GradingResult> gradingResults;
    List<ModuleClass> moduleClasses;
    List<Attendance> attendances;
    String formatedDate;
    String error;

    Student(
        {this.id,
            this.firstName,
            this.lastName,
            this.gender,
            this.dateOfBirth,
            this.address,
            this.numberPhone,
            this.email,
            this.imageProfile,
            this.familyNumber,
            this.mainClass,
            this.gradingResults,
            this.moduleClasses,
            this.attendances,
            this.formatedDate});

    Student.withError({@required this.error}) : assert(error != null);

    Student.fromJson(Map<String, dynamic> json) {
        id = json['id'];
        firstName = json['firstName'];
        lastName = json['lastName'];
        gender = json['gender'];
        dateOfBirth = json['dateOfBirth'];
        address = json['address'];
        numberPhone = json['numberPhone'];
        email = json['email'];
        imageProfile = json['imageProfile'];
        familyNumber = json['familyNumber'];
        mainClass = json['mainClass'] != null ? new MainClass.fromJson(json['mainClass']) : null;
        if (json['gradingResults'] != null) {
            gradingResults = new List<GradingResult>();
            json['gradingResults'].forEach((v) {
                gradingResults.add(new GradingResult.fromJson(v));
            });
        }
        if (json['moduleClasses'] != null) {
            moduleClasses = new List<ModuleClass>();
            json['moduleClasses'].forEach((v) {
                moduleClasses.add(new ModuleClass.fromJson(v));
            });
        }
        if (json['attendances'] != null) {
            attendances = new List<Attendance>();
            json['attendances'].forEach((v) {
                attendances.add(new Attendance.fromJson(v));
            });
        }
        formatedDate = json['formatedDate'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['firstName'] = this.firstName;
        data['lastName'] = this.lastName;
        data['gender'] = this.gender;
        data['dateOfBirth'] = this.dateOfBirth;
        data['address'] = this.address;
        data['numberPhone'] = this.numberPhone;
        data['email'] = this.email;
        data['imageProfile'] = this.imageProfile;
        data['familyNumber'] = this.familyNumber;
        if (this.mainClass != null) {
            data['mainClass'] = this.mainClass.toJson();
        }
        if (this.gradingResults != null) {
            data['gradingResults'] =
                this.gradingResults.map((v) => v.toJson()).toList();
        }
        if (this.moduleClasses != null) {
            data['moduleClasses'] =
                this.moduleClasses.map((v) => v.toJson()).toList();
        }
        if (this.attendances != null) {
            data['attendances'] = this.attendances.map((v) => v.toJson()).toList();
        }
        data['formatedDate'] = this.formatedDate;
        return data;
    }
}