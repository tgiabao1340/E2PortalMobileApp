import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../app_config.dart';

class CardInfo extends StatelessWidget {
  final String label;
  final String textInfo;

  const CardInfo({this.label, @required this.textInfo});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5),
      elevation: 4.0,
      child: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            FittedBox(
              child: Text(
                label,
                style: AppTheme.TextCardLabel,
              ),
            ),
            Expanded(
              child: Text(
                textInfo,
                style: AppTheme.TextCardInfo,
              ),
            )
          ],
        ),
      )
    );
  }
}
