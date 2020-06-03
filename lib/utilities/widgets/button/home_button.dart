import 'package:e2portal/app_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String text;
  final IconData icon;

  const HomeButton({this.onPressed, this.text, this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      margin: new EdgeInsets.all(15),
      child: RaisedButton(
        color: AppTheme.CARD_BACKGROUND,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15),
              child: Icon(
                this.icon,
                size: 60,
                color: AppTheme.STROKE,
              ),
            ),
            Text(
              text,
              style: AppTheme.HomeTextStyle,
            ),
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}
