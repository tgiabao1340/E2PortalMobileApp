
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'announcement.g.dart';

@JsonSerializable()
class Announcement{
  String title;
  String summary;
  String contentDetail;
  String createDate;
  String formattedCreatedDate;
  @JsonKey(ignore: true)
  String error;

  Announcement();
  Announcement.withError({@required this.error}) : assert(error != null);
  factory Announcement.fromJson(Map<String, dynamic> json) => _$AnnouncementFromJson(json);
  Map<String, dynamic> toJson() => _$AnnouncementToJson(this);

}