
import 'package:e2portal/api/provider/api_profile_provider.dart';
import 'package:e2portal/data/announcements_data.dart';
import 'package:e2portal/data/student_data.dart';
import 'package:e2portal/data/timetable_data.dart';
import 'package:e2portal/model/lecturer.dart';
import 'package:e2portal/model/model.dart';

class ApiProfileRepository{
  final ApiProfileProvider _apiProfileProvider = ApiProfileProvider();

  Future<Student> getStudent() =>_apiProfileProvider.getStudent();

  Future<StudentData> getListStudent() =>_apiProfileProvider.getListStudent();

  Future<AnnouncementsData> getAnnouncements(int page) => _apiProfileProvider.getAnnouncements(page);

  Future<TimeTableData> getTimeTable(String moduleClassId) => _apiProfileProvider.getTimeTable(moduleClassId);

  Future<int> getTotalDayModuleClass(String moduleClassId) => _apiProfileProvider.getTotalDay(moduleClassId);

  Future<Lecturer> getMainClassLecturer(String mainClassId) => _apiProfileProvider.getMainClassLecturer(mainClassId);

  Future<Lecturer> getLecturerByModuleClass(String moduleClassId) => _apiProfileProvider.getLecturerByModuleClass(moduleClassId);

}