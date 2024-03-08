import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget appButton({color, title, onPress}) {
  return MaterialButton(
    minWidth: Get.width,
    height: 50,
    child: title,
      color: color,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onPressed: onPress);
}
