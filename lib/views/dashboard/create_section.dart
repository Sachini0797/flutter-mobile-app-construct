import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:responsive_sizer/responsive_sizer.dart' as res;
import 'package:responsive_toolkit/breakpoints.dart';


class CreateSection extends StatelessWidget {
  const CreateSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(
                    child: GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 3, 5, 0),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: const Color.fromRGBO(226, 3, 47, 1.0)),
                                  color: const Color.fromRGBO(226, 3, 47, 1.0)),
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                      width: double.infinity,
                                      padding:
                                      const EdgeInsets.fromLTRB(5, 5, 3, 0),
                                      child:  Text("Want to Sell or Lease?",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              // fontSize: res.Device.screenType== res.ScreenType.tablet ? 18 : 12
                                              fontSize: Breakpoints(xs: 12.0, sm: 15.0,md: 18.0,lg: 20.0).choose(Get.width)

                                          ))),
                                  Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.white),
                                      width: double.infinity,
                                      padding:
                                      const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                      child:  Text(
                                        'CREATE SALE / LEASE',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color.fromRGBO(226, 3, 47, 1.0),
                                            fontWeight: FontWeight.bold,
                                            fontSize:  Breakpoints(xs: 15.0, sm: 18.0,md: 20.0,lg: 20.0).choose(Get.width)),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {

                      },
                    )),
                Flexible(
                    child: GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 3, 0, 0),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: const Color.fromRGBO(226, 3, 47, 1.0)),
                                  color: const Color.fromRGBO(226, 3, 47, 1.0)),
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                      width: double.infinity,
                                      padding:
                                      const EdgeInsets.fromLTRB(5, 5, 3, 0),
                                      child:   Text("Have a Need?",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: Breakpoints(xs: 12.0, sm: 15.0,md: 18.0,lg: 20.0).choose(Get.width)))),
                                  Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.white),
                                      width: double.infinity,
                                      padding:
                                      const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                      child:  Text(
                                        'MAKE REQUESTS',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color.fromRGBO(226, 3, 47, 1.0),
                                            fontWeight: FontWeight.bold,
                                            fontSize: Breakpoints(xs: 15.0, sm: 18.0,md: 20.0,lg: 20.0).choose(Get.width)),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                                            },
                    ))
              ],
            ),
          ),
        ],
      );
  }
}
