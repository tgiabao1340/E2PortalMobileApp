part of 'announcement.dart';

Announcement _$AnnouncementFromJson(Map<String, dynamic> json){
  return Announcement()
    ..title = json['title'] as String
      ..summary = json['summary'] as String
      ..contentDetail = json['contentDetail'] as String
      ..createDate = json['createdDate'] as String
      ..formattedCreatedDate = json['formattedCreatedDate'] as String;

}

Map<String, dynamic> _$AnnouncementToJson(Announcement instance) =>
    <String, dynamic>{
  'title': instance.title,
  'summary': instance.summary,
  'contentDetail': instance.contentDetail,
  'createDate': instance.createDate,
  'formattedCreatedDate': instance.formattedCreatedDate,
};