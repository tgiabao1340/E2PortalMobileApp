import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_body.g.dart';
@JsonSerializable()
class LoginBody{
  final String id;
  final String password;

  LoginBody({@required this.id,@required this.password}) : assert(id != null && id != ""), assert(password != null && password != "");

  factory LoginBody.fromJson(Map<String, dynamic> json) => _$LoginBodyFromJson(json);

  Map<String, dynamic> toJson() => _$LoginBodyToJson(this);

}