import 'dart:collection';
import 'package:e2portal/api/repository/api_profile_repository.dart';
import 'package:e2portal/model/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../app_config.dart';

class ParentScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new _ParentState();
  }
}

class _ParentState extends State<ParentScreen> {
  ApiProfileRepository _apiProfileRepository = ApiProfileRepository();
  LinkedHashMap<String, Student> list = LinkedHashMap();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phụ huynh"),
        backgroundColor: AppTheme.HEADLINE,
      ),
      body: Container(
        child: Center(
          child: Text(
            "Parent screen"
          ),
        )
      ),
    );
  }
}
