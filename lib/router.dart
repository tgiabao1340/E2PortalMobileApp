
import 'dart:collection';
import 'package:e2portal/model/model.dart';
import 'package:e2portal/ui/ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String initRoute = '/';
const String homeRoute = '/home';
const String loginRoute = '/login';
const String profileRoute = '/profile';
const String announcementRoute = '/announcement';
const String gradingRoute = '/gradingresult';
const String gradingDetailRoute = '/grading_detail';
const String attendanceRoute = '/attandance';
const String attendanceDetailRoute = '/attandance_detail';
const String timetableRoute = '/timetable';
const String lectureRoute = '/lecture';
const String parentRoute = '/parent';
const String studentListRoute = '/studentList';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case parentRoute:
        return MaterialPageRoute(builder: (_) => LoginParent());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case homeRoute:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case studentListRoute:
        return MaterialPageRoute(builder: (_) => ParentScreen());
      case profileRoute:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case announcementRoute:
        return MaterialPageRoute(builder: (_) => AnnouncementScreen());
      case gradingRoute:
        return MaterialPageRoute(builder: (_) => GradingResultScreen(student: settings.arguments));
      case gradingDetailRoute:
        Map args = settings.arguments as Map;
        String semester = args['semester'];
        List<ModuleClass> list = args['list'];
        LinkedHashMap<String, GradingResult> gradingResults = args['gradingResult'];
        return MaterialPageRoute(builder: (_) => GradingResultDetailScreen(listModuleClass: list,listGradingResult: gradingResults, semester: semester));
      case attendanceRoute:
        return MaterialPageRoute(builder: (_) => AttendanceScreen(student: settings.arguments));
      case attendanceDetailRoute:
        Map args = settings.arguments as Map;
        String semester = args['semester'];
        List<ModuleClass> list = args['list'];
        LinkedHashMap<String, List<Attendance>> attendances = args['attendances'];
        return MaterialPageRoute(builder: (_) => AttendanceDetailScreen(listModuleClass: list,listAttendance: attendances, semester: semester));
      case timetableRoute:
        return MaterialPageRoute(builder: (_) => TimeTableScreen(moduleClasses: settings.arguments));
      case lectureRoute:
        return MaterialPageRoute(builder: (_) => LectureScreen(student: settings.arguments));

      default:
        return MaterialPageRoute(builder: (_) => SplashScreen());
    }
  }
}
