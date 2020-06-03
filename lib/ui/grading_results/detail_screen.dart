import 'dart:collection';
import 'package:e2portal/model/model.dart';
import 'package:e2portal/utilities/utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../app_config.dart';

class GradingResultDetailScreen extends StatelessWidget {
  final List<ModuleClass> listModuleClass;
  final LinkedHashMap<String, GradingResult> listGradingResult;
  final String semester;

  GradingResultDetailScreen({@required this.listModuleClass, this.semester, this.listGradingResult});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(semester),
        backgroundColor: AppTheme.HEADLINE,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: ListView.builder(
          itemCount: listModuleClass.length,
          itemBuilder: (context, index) {
            ModuleClass moduleClass = listModuleClass.elementAt(index);
            GradingResult gradingResult = listGradingResult[moduleClass.moduleClassId];
            return Column(
              children: [
                GestureDetector(
                  onTap: () => {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Container(
                                  height: 50,
                                  alignment: Alignment.center,
                                  child: Text(
                                    moduleClass.moduleClassName,
                                    style: AppTheme.TextCardLabel,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      flex: 2,
                                      child: CardTitleScore(text: "Thường Kỳ"),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: CardScore(score: gradingResult != null ? gradingResult.quiz1 : null),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: CardScore(score: gradingResult != null ? gradingResult.quiz2 : null),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: CardScore(score: gradingResult != null ? gradingResult.quiz3 : null),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: CardScore(score: gradingResult != null ? gradingResult.quiz4 : null),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: CardScore(score: gradingResult != null ? gradingResult.quiz5 : null),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      flex: 2,
                                      child: CardTitleScore(text: "Giữa Kỳ"),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: CardScore(score: gradingResult != null ? gradingResult.midScore : null),
                                    ),
                                    Flexible(
                                      flex: 4,
                                      child: Container(),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      flex: 2,
                                      child: CardTitleScore(text: "Thực hành"),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: CardScore(score: gradingResult != null ? gradingResult.practiceScore1 : null),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: CardScore(score: gradingResult != null ? gradingResult.practiceScore2 : null),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: CardScore(score: gradingResult != null ? gradingResult.practiceScore3 : null),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: CardScore(score: gradingResult != null ? gradingResult.practiceScore4 : null),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: CardScore(score: gradingResult != null ? gradingResult.practiceScore5 : null),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      flex: 2,
                                      child: CardTitleScore(text: "Cuối Kỳ"),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: CardScore(score: gradingResult != null ? gradingResult.endScore : null),
                                    ),
                                    Flexible(
                                      flex: 4,
                                      child: Container(),
                                    )
                                  ],
                                ),
                                Divider(),
                                Container(
                                  child: Row(
                                    children: [
                                      Flexible(
                                        fit: FlexFit.tight,
                                        flex: 4,
                                        child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                            border: Border.all(),
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                "Tổng",
                                                style: AppTheme.TextCardLabel,
                                              ),
                                              Text(
                                                gradingResult != null ? gradingResult.averageScore.toString() : " ",
                                                style: AppTheme.TextCardInfo,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Flexible(
                                        flex: 2,
                                        child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                            border: Border.all(),
                                          ),
                                          alignment: Alignment.center,
                                          child: FittedBox(
                                            child: Text(
                                              gradingResult != null ? _gpaConverter(gradingResult.averageScore) : " ",
                                              style: AppTheme.BigTextStyle,
                                            ),
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                Divider(),
                                FlatButton(
                                  onPressed: () => {Navigator.pop(context)},
                                  child: Text("Đóng"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  },
                  child: Card(
                    elevation: 8.0,
                    child: Container(
                      decoration: BoxDecoration(border: Border.all()),
                      alignment: Alignment.center,
                      child: Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(border: Border.all()),
                                  padding: EdgeInsets.all(5),
                                  width: 150,
                                  height: 100,
                                  child: Column(
                                    children: [
                                      Text(
                                        "Tổng",
                                        style: AppTheme.TextCardLabel,
                                      ),
                                      Text(
                                        gradingResult != null ? _gpaConverter(gradingResult.endScore) : " ",
                                        style: AppTheme.BigTextStyle,
                                      ),
                                      Text(
                                        gradingResult != null ? gradingResult.averageScore.toString() : " ",
                                        style: AppTheme.TextCardInfo,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 100,
                                    decoration: BoxDecoration(border: Border.all()),
                                    padding: EdgeInsets.all(15),
                                    alignment: Alignment.center,
                                    child: Column(children: [
                                      Text(
                                        moduleClass.moduleClassId,
                                        style: AppTheme.TextCardLabel,
                                      ),
                                      Text(
                                        moduleClass.moduleClassName,
                                        style: AppTheme.TextCardInfo,
                                      )
                                    ]),
                                  ),
                                )
                              ],
                            ),
                            Container(
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Container(
                                          width: double.maxFinite,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(border: Border.all()),
                                          child: Text(
                                            "TK",
                                            style: AppTheme.TextCardLabel,
                                          ),
                                        ),
                                        Container(
                                          width: double.maxFinite,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(border: Border.all()),
                                          child: Text(
                                            gradingResult != null
                                                ? ((gradingResult.quiz1 +
                                                            gradingResult.quiz2 +
                                                            gradingResult.quiz3 +
                                                            gradingResult.quiz4 +
                                                            gradingResult.quiz5) /
                                                        5)
                                                    .toString()
                                                : " ",
                                            style: AppTheme.TextCardInfo,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Container(
                                          width: double.maxFinite,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(border: Border.all()),
                                          child: Text(
                                            "GK",
                                            style: AppTheme.TextCardLabel,
                                          ),
                                        ),
                                        Container(
                                          width: double.maxFinite,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(border: Border.all()),
                                          child: Text(
                                            gradingResult != null ? (gradingResult.midScore).toString() : " ",
                                            style: AppTheme.TextCardInfo,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Container(
                                          width: double.maxFinite,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(border: Border.all()),
                                          child: Text(
                                            "TH",
                                            style: AppTheme.TextCardLabel,
                                          ),
                                        ),
                                        Container(
                                          width: double.maxFinite,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(border: Border.all()),
                                          child: Text(
                                            gradingResult != null
                                                ? ((gradingResult.practiceScore1 +
                                                            gradingResult.practiceScore2 +
                                                            gradingResult.practiceScore3 +
                                                            gradingResult.practiceScore4 +
                                                            gradingResult.practiceScore5) /
                                                        5)
                                                    .toString()
                                                : " ",
                                            style: AppTheme.TextCardInfo,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Container(
                                          width: double.maxFinite,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(border: Border.all()),
                                          child: Text(
                                            "CK",
                                            style: AppTheme.TextCardLabel,
                                          ),
                                        ),
                                        Container(
                                          width: double.maxFinite,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(border: Border.all()),
                                          child: Text(
                                            gradingResult != null ? (gradingResult.endScore).toString() : " ",
                                            style: AppTheme.TextCardInfo,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Divider()
              ],
            );
          },
        ),
      ),
    );
  }

  String _gpaConverter(double score) {
    if (score >= 0.0 && score <= 5.9) return "F";
    if (score >= 6.0 && score <= 6.2) return "D-";
    if (score >= 6.3 && score <= 6.6) return "D";
    if (score >= 6.7 && score <= 6.9) return "D+";
    if (score >= 7.0 && score <= 7.2) return "C-";
    if (score >= 7.3 && score <= 7.6) return "C";
    if (score >= 7.7 && score <= 7.9) return "C+";
    if (score >= 8.0 && score <= 8.2) return "B-";
    if (score >= 8.3 && score <= 8.6) return "B";
    if (score >= 8.7 && score <= 8.9) return "B+";
    if (score >= 9.0 && score <= 9.2) return "A-";
    if (score >= 9.3 && score <= 10.0) return "A";
    return "";
  }
}
