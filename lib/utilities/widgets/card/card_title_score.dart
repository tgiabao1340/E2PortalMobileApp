import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardTitleScore extends StatelessWidget{
  final String text;

  const CardTitleScore({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 50,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        alignment: Alignment.center,
        child: FittedBox(
          child: Text(
              text
          ),
        )
      ),
    );
  }

}