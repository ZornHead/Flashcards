import 'package:flutter/material.dart';
import 'package:flutter_app/constants/day_theme.dart';
import 'package:flutter_app/utils/scaler_config.dart';
import 'package:get/get.dart';

class Input extends StatelessWidget {
  final ScalerConfig scaler = Get.find(tag: 'scaler');

  final labelText;
  final initialValue;
  final obscureText;
  final validator;
  final TextInputType keyboardtype;
  final TextCapitalization textCapitalization;
  final void Function(String) onChanged;
  final void Function() onEditingComplete;
  final TextInputAction textInputAction;
  final FocusNode focusNode;

  Input({
    @required this.labelText,
    this.initialValue,
    this.obscureText = false,
    this.onChanged,
    this.validator,
    this.keyboardtype,
    this.textCapitalization = TextCapitalization.none,
    this.onEditingComplete,
    this.textInputAction,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: textStyle(
          fontSize: scaler.scalerT(15.0), fontWeight: FontWeight.w600),
      textCapitalization: textCapitalization,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: keyboardtype,
      obscureText: obscureText,
      validator: validator,
      initialValue: initialValue,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelStyle: textStyle(
            fontSize: scaler.scalerT(14.0), fontWeight: FontWeight.w500),
        labelText: labelText,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: DayTheme.primaryColor,
          ),
        ),
        hoverColor: DayTheme.primaryColor,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: DayTheme.textColor,
          ),
        ),
      ),
      textAlignVertical: TextAlignVertical.center,
      onEditingComplete: onEditingComplete,
      textInputAction: textInputAction,
      focusNode: focusNode,
    );
  }
}
