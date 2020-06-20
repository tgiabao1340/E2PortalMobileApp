import 'package:e2portal/app_config.dart';
import 'package:e2portal/model/model.dart';
import 'package:e2portal/utilities/utilities.dart';
import 'package:e2portal/utilities/widgets/button/parent_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../router.dart';

class CardStudent extends StatelessWidget{
  final Student student;

  const CardStudent({@required this.student});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 8.0,
          child: Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Flexible(
                        flex: 2,
                        child: Center(
                          child: Text(
                              student.id,
                            style: AppTheme.TextToday,
                          ),
                        )
                    ),
                    Flexible(
                        flex: 4,
                        child: Center(
                          child: Text(
                              student.lastName +" "+ student.firstName,
                            style: AppTheme.TextCardLabel,
                          ),
                        )
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: ParentButton(
                        text: 'Kết quả học tập',
                        onPressed: () => {Navigator.of(context).pushNamed(gradingRoute, arguments: student)},
                      ),
                    ),
                    Expanded(
                      child: ParentButton(
                        text: 'Điểm danh',
                        onPressed: () => {Navigator.of(context).pushNamed(attendanceRoute, arguments: student)},
                      ),
                    )
                  ],
                )
              ],
            )
          )
    );
  }

}