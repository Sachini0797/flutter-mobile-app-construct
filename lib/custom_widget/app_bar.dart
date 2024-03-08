import 'package:construct/consts/colors.dart';
import 'package:construct/consts/images.dart';
import 'package:construct/custom_widget/dashboard_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

PreferredSizeWidget myAppBar(String title, BuildContext context) {
  bool dashboard = false;
  return AppBar(
    backgroundColor: appColor,
    foregroundColor: Colors.white,
    // Hero(tag: title.toLowerCase().replaceAll(' ', '_'))
    title: Text(title),
    centerTitle: true,
    shadowColor: Colors.transparent,
    actions: [
      Container(
        width: 55,
        child: Image.asset(appWhiteLogo, fit: BoxFit.cover),
      )
    ],
  );
}

PreferredSizeWidget myDashboardAppBar() {
  bool dashboard = false;
  return AppBar(
    backgroundColor: appColor,
    foregroundColor: Colors.white,

    title: DashboardSearch(),
    // title: MainSearchFiels(),
    centerTitle: true,
    shadowColor: Colors.transparent,

    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 5),
        child: Container(
          width: 50,
          child: Hero(
            tag: 'logo',
            child: Image.asset(appWhiteLogo, fit: BoxFit.cover),
          ),
        ),
      )
    ],
  );
}
