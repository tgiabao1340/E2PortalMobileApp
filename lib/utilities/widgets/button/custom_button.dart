import 'package:e2portal/app_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String text;
  const CustomButton({@required this.onPressed, @required this.text}) : assert(onPressed != null);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 5.5,
      onPressed: onPressed,
      padding: EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      color: AppTheme.BUTTON,
      child: FittedBox(
        child: Text(
          text,
          style: AppTheme.ButtonTextStyle,
        ),
      )
    );
  }
}
