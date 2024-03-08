
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

InputDecoration textFieldStyles ( { label,hintText,prefixIcon, suffixIcon }) {
  return InputDecoration(
      label: label,
      hintText: hintText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      border: InputBorder.none,
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red)));
}