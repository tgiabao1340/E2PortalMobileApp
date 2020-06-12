import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../app_config.dart';

class CustomButtonParent extends StatelessWidget{
  final GestureTapCallback onPressed;
  final String text;
  const CustomButtonParent({@required this.onPressed, @required this.text}) : assert(onPressed != null);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        elevation: 5.5,
        onPressed: onPressed,
        padding: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        color: AppTheme.BUTTON_PARENT,
        child: FittedBox(
          child: Text(
            text,
            style: AppTheme.ButtonSecondTextStyle,
          ),
        )
    );
  }
}