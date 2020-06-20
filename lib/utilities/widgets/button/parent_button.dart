import 'package:e2portal/app_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ParentButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String text;

  const ParentButton({this.onPressed, this.text});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        color: AppTheme.CARD_BACKGROUND,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              text,
              style: AppTheme.HomeTextStyle,
            ),
          ],
        ),
        onPressed: onPressed,
    );
  }
}
