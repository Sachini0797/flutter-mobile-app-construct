import 'package:flutter/material.dart';

class FormThemeHelper {
  InputDecoration formTextInputStyle(
      [String labelText = " ",
        String hintText = " ",
        suffixText = " ",
        Color color = Colors.white]) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      suffixText: suffixText,
      filled: true,
      fillColor: color,
      contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.white70)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.grey)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.grey.shade400)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.red,
          )),
    );
  }
}
