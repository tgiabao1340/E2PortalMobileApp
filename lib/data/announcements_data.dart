import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:e2portal/model/announcement/announcement.dart';

class AnnouncementsData{
  List<Announcement> announcements = [];
  int statusCode;
  String error;
  int total;
  int nItems;

  AnnouncementsData.fromResponse(Response response){
    this.statusCode = response.statusCode;
    Map<String, dynamic> data = jsonDecode(response.data);
    Map<String, dynamic> _embedded = data['_embedded'];
    List announcementList = _embedded['announcements'];
    announcementList.forEach((element) {
      announcements.add(Announcement.fromJson(element));
    });
    Map<String, dynamic> page = data['page'];
    total = page['totalElements'] ;
    nItems = 5;
  }
  AnnouncementsData.withError(String error){
    this.error = error;
  }
}