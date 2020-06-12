import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppConfig{

  final String apiUrl;
  AppConfig({this.apiUrl});
  static Future<AppConfig> loadConfig() async{
    final contents = await rootBundle.loadString('assets/config/config.json');
    final json = jsonDecode(contents);
    return AppConfig(apiUrl: json['apiUrl']);

  }


}


class AppTheme{
  static const Color BACKGROUND = Color(0xFFfffffe);
  static const Color HOME_BACKGROUND = Color(0xFFd8eefe);
  static const Color HEADLINE = Color(0xFF094067);
  static const Color PARAGRAPH = Color(0xFF5f6c7b);
  static const Color BUTTON = Color(0xFF3da9fc);
  static const Color BUTTON_PARENT = Color(0xFFfffffe);
  static const Color BUTTON_TEXT = Color(0xFFfffffe);
  static const Color CARD_BACKGROUND = Color(0xFFfffffe);
  static const Color STROKE = Color(0xFF094067);
  static const Color MAIN = Color(0xFFfffffe);
  static const Color HIGHLIGHT = Color(0xFF3da9fc);
  static const Color SECONDARY = Color(0xFF90b4ce);
  static const Color TERTIARY = Color(0xFFef4565);
  static const Color LABEL = Color(0xFF094067);
  static const Color PLACEHOLDER = Color(0xFF094067);
  static const Color TEXT_INPUT = Color(0xFF094067);
  static const Color FORM_INPUT = Color(0xFFfffffe);
  static const Color FORM_BUTTON_TEXT = Color(0xFFfffffe);
  static const Color FORM_BUTTON = Color(0xFFef4565);

  static const HintTextStyle = TextStyle(
    color: PLACEHOLDER,
    fontFamily: 'OpenSans',
  );
  static const InputTextStyle = TextStyle(
    color: TEXT_INPUT,
    fontFamily: 'OpenSans',
  );
  static const HomeTextStyle = TextStyle(
    color: HEADLINE,
    fontFamily: 'OpenSans',
  );
  static const LabelTextStyle = TextStyle(
    color: LABEL,
    fontWeight: FontWeight.bold,
    fontFamily: 'OpenSans',
  );
  static const ButtonTextStyle = TextStyle(
    color: BUTTON_TEXT,
    letterSpacing: 1.5,
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    fontFamily: 'OpenSans',
  );
  static const LogoTextStyle = TextStyle(
    color: STROKE,
    fontSize: 30,
    fontWeight: FontWeight.w900,
    letterSpacing: 5,
    fontFamily: 'OpenSans',
  );
  static const TextCardLabel = TextStyle(
    color: LABEL,
    fontSize: 12.0,
    fontWeight: FontWeight.bold,
    fontFamily: 'OpenSans',
  );
  static const TextCardInfo = TextStyle(
    color: HIGHLIGHT,
    fontSize: 12,
    fontWeight: FontWeight.bold,
    fontFamily: 'OpenSans',
  );

  static const LogoDrawerStyle = TextStyle(
    color: MAIN,
    fontSize: 30,
    fontWeight: FontWeight.bold,
    letterSpacing: 5,
    fontFamily: 'OpenSans',
  );

  static const BigTextStyle = TextStyle(
    color: HEADLINE,
    fontSize: 30,
    fontWeight: FontWeight.bold,
    letterSpacing: 5,
    fontFamily: 'OpenSans',
  );

  static const TextCardScore =  TextStyle(
  color: HEADLINE,
  fontSize: 10,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
  );

  static const TextCardSubtitle = TextStyle(
  color: PARAGRAPH,
  fontSize: 10,
  fontWeight: FontWeight.w400,
  fontFamily: 'OpenSans',
  );

  static const TextToday =  TextStyle(
    color: LABEL,
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    fontFamily: 'OpenSans',
  );

  static const ButtonSecondTextStyle = TextStyle(
    color: HEADLINE,
    letterSpacing: 1.5,
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    fontFamily: 'OpenSans',
  );


}