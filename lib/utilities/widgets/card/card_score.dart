import 'package:e2portal/model/grading_result/grading_result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../app_config.dart';

class CardScore extends StatelessWidget {
  final double score;

  const CardScore({@required this.score});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 50,
        alignment: Alignment.center,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(border: Border.all()),
        child: FittedBox(
          child: Text(
            score != null ? score.toString() : " ",
            style: AppTheme.TextCardScore,
          ),
        )
      ),
    );
  }
}
