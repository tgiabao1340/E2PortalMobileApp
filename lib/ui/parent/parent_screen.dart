import 'dart:collection';
import 'package:e2portal/api/repository/api_profile_repository.dart';
import 'package:e2portal/bloc/blocs.dart';
import 'package:e2portal/data/student_data.dart';
import 'package:e2portal/model/model.dart';
import 'package:e2portal/utilities/utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_config.dart';
import '../../router.dart';

class ParentScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _ParentState();
  }
}

class _ParentState extends State<ParentScreen> {
  ApiProfileRepository _apiProfileRepository = ApiProfileRepository();
  List<Student> list;
  @override
  void initState() {
    getListStudent();
    super.initState();
  }
  getListStudent() async {
    StudentData studentData = await _apiProfileRepository.getListStudent();
    if(studentData.error.isNotEmpty) {
      list = studentData.list;
    }else{
      list = [];
    }
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationUnauthenticated) {
          Navigator.pushNamedAndRemoveUntil(
              context, loginRoute, (route) => false);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Phụ huynh"),
          backgroundColor: AppTheme.HEADLINE,
        ),
        drawer: DrawerMenuParent(),
        body: Container(
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index){
                return;
              },
            ),
        ),
      ),
    );
  }
}
