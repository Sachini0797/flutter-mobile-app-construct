import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_toolkit/breakpoints.dart';

import '../../controllers/dashboard_controller.dart';


class DashboardCards extends GetView<DashboardController> {
  final dashboardCtrl = Get.find<DashboardController>();

  DashboardCards({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // return getNewGrid();
    return getNewGrid();
  }

  getNewGrid() {
     return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [

        Container(
          margin: EdgeInsets.fromLTRB(5, 0, 5, 10),
          decoration: const BoxDecoration(
            color: Color.fromRGBO(226, 3, 47, 1.0),
            borderRadius: BorderRadius.all(Radius.circular(12)),
            border:
            Border.fromBorderSide(BorderSide(color: Colors.grey)),
            // boxShadow: [BoxShadow(blurRadius: 8,color: Colors.white,offset: Offset(1,2))]
            shape: BoxShape.rectangle,
          ),
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child:   getGrid()
          ,)
      ],);


  }

  getGrid() {
    return GridView.count(
      childAspectRatio: 1.7,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(8),
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      crossAxisCount: Breakpoints(xs: 2, sm: 2, md: 2, lg: 3).choose(Get.width),
      // crossAxisCount: res.Device.screenType == res.ScreenType.tablet ? 3 : 2,
      children: <Widget>[
        GestureDetector(
          onTap: () {
           },
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.fromBorderSide(BorderSide(color: Colors.grey)),
              // boxShadow: [BoxShadow(blurRadius: 8,color: Colors.white,offset: Offset(1,2))]
              shape: BoxShape.rectangle,
            ),
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/dashboard_icons/PendingTransaction.png',
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text(
                      "Pending \nTransactions ",
                      style: TextStyle(fontSize: Breakpoints(xs: 14.0,sm: 16.0,md: 18.0,lg: 0.8).choose(Get.width)),
                    ),

                    Obx(() => Text(
                      dashboardCtrl.pendingTransactions.toString(),
                      style: TextStyle(fontSize: Breakpoints(xs: 30.0,sm: 30.0,md: 30.0,lg: 35.0).choose(Get.width), color: Color(0xffE4032F)),
                    ))
                  ]),
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {

          },
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.fromBorderSide(BorderSide(color: Colors.grey)),
              // boxShadow: [BoxShadow(blurRadius: 8,color: Colors.white,offset: Offset(1,2))]
              shape: BoxShape.rectangle,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/dashboard_icons/inbox.png',
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(
                    "Inbox",
                    style: TextStyle(fontSize: Breakpoints(xs: 14.0,sm: 16.0,md: 18.0,lg: 0.8).choose(Get.width)),
                  ),
                  Obx(() => Text(
                    dashboardCtrl.inbox.toString(),
                    style: TextStyle(fontSize:  Breakpoints(xs: 30.0,sm: 30.0,md: 30.0,lg: 35.0).choose(Get.width), color: Color(0xffE4032F)),
                  ))
                ])
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.fromBorderSide(BorderSide(color: Colors.grey)),
              // boxShadow: [BoxShadow(blurRadius: 8,color: Colors.white,offset: Offset(1,2))]
              shape: BoxShape.rectangle,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/dashboard_icons/Review.png',
                  height: 61,
                  width: 61,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(
                    "Reviews",
                    style: TextStyle(fontSize: Breakpoints(xs: 14.0,sm: 16.0,md: 18.0,lg: 0.8).choose(Get.width)),
                  ),
                  Obx(() => Text(
                    dashboardCtrl.reviews.toString(),
                    style: TextStyle(fontSize:  Breakpoints(xs: 30.0,sm: 30.0,md: 30.0,lg: 35.0).choose(Get.width), color: Color(0xffE4032F)),
                  ))
                ])
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.fromBorderSide(BorderSide(color: Colors.grey)),
              // boxShadow: [BoxShadow(blurRadius: 8,color: Colors.white,offset: Offset(1,2))]
              shape: BoxShape.rectangle,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/dashboard_icons/Performance.png',
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(
                    "Performance",
                    style: TextStyle(fontSize: Breakpoints(xs: 14.0,sm: 16.0,md: 18.0,lg: 0.8).choose(Get.width)),
                  ),
                  Obx(() => Text(
                    dashboardCtrl.performance.toString(),
                    style: TextStyle(fontSize:  Breakpoints(xs: 30.0,sm: 30.0,md: 30.0,lg: 35.0).choose(Get.width), color: Color(0xffE4032F)),
                  ))
                ])
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.fromBorderSide(BorderSide(color: Colors.grey)),
              // boxShadow: [BoxShadow(blurRadius: 8,color: Colors.white,offset: Offset(1,2))]
              shape: BoxShape.rectangle,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/dashboard_icons/Unsuccessful.png',
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(
                    "Unsuccessful \nOrders",
                    style: TextStyle(fontSize: Breakpoints(xs: 14.0,sm: 16.0,md: 18.0,lg: 0.8).choose(Get.width)),
                  ),
                  Obx(() => Text(
                    dashboardCtrl.unsuccessfulOrders.toString(),
                    style: TextStyle(fontSize:  Breakpoints(xs: 30.0,sm: 30.0,md: 30.0,lg: 35.0).choose(Get.width), color: Color(0xffE4032F)),
                  ))
                ])
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.fromBorderSide(BorderSide(color: Colors.grey)),
              // boxShadow: [BoxShadow(blurRadius: 8,color: Colors.white,offset: Offset(1,2))]
              shape: BoxShape.rectangle,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/dashboard_icons/completed.png',
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(
                    "Completed \nOrders",
                    style: TextStyle(fontSize: Breakpoints(xs: 14.0,sm: 16.0,md: 18.0,lg: 0.8).choose(Get.width)),
                  ),
                  Obx(() => Text(
                    dashboardCtrl.completedOrders.toString(),
                    style: TextStyle(fontSize:  Breakpoints(xs: 30.0,sm: 30.0,md: 30.0,lg: 35.0).choose(Get.width), color: Color(0xffE4032F)),
                  ))
                ])
              ],
            ),
          ),
        ),
      ],
    );
  }


}
