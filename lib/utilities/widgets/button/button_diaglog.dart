import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogButton extends StatelessWidget{
  final String text;
  final GestureTapCallback onPressed;
  const DialogButton({@required this.text, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      onPressed: onPressed,
      child: Text(text),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius:  BorderRadius.circular(30.0),
      ),
    );
  }

}