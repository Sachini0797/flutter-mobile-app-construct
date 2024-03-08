
import 'package:construct/consts/colors.dart';
import 'package:construct/consts/images.dart';
import 'package:construct/views/dashboard/home_carousel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/dashboard_controller.dart';


class ActionMenu extends StatelessWidget {
  final dashboardCtrl = Get.put<DashboardController>;

  ActionMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            padding: const EdgeInsets.only(top: 20, left: 8, right: 8),
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.6, 0.4],
                colors: [
                  appColor,
                  Color(0xffcb0c35),
                ],
              ),
              // border: Border.all(color: Colors.white)
              // boxShadow: [BoxShadow(blurRadius: 8,color: Colors.white,offset: Offset(1,2))]
            ),
            child: Column(
              children: [
                const HomeCarousel(),

                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      GestureDetector(
                        onTap: (){

                        },
                        child: Hero(
                          tag: 'proimg',
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            height: 70,
                            width: 70,
                            decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(100))),
                            child: Image.asset(
                              user,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 5, 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Hello,", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w100, color: Colors.white)),
                            Text('Mark Anthony'+'👋', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),

      ],
    );
  }
}
