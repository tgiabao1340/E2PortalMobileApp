import 'package:e2portal/app_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final IconData prefixIcon;
  final String hint;
  final String error;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;

  const CustomTextField(
      {@required this.label,
      this.prefixIcon,
      @required this.hint,
        this.obscureText,
      @required this.error,
      this.controller,
      this.validator, this.keyboardType})
      : assert(label != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          this.label,
          style: AppTheme.LabelTextStyle,
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          height: 80.0,
          child: TextFormField(
            controller: controller,
            obscureText: obscureText == null ? false : true,
            style: AppTheme.InputTextStyle,
            validator: this.validator,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), gapPadding: 0.0),
              contentPadding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
              prefixIcon: Icon(
                prefixIcon,
                color: AppTheme.PLACEHOLDER,
              ),
              hintText: this.hint,
              hintStyle: AppTheme.HintTextStyle,
              errorStyle: TextStyle(
                color: Colors.red,
                fontSize: 14.0,
              ),
            ),
          ),
        )
      ],
    );
  }
}
