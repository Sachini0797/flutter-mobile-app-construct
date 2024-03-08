import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:responsive_toolkit/breakpoints.dart';
import '../../controllers/dashboard_controller.dart';

class InformationSection extends StatelessWidget {
  final dashboardCtrl = Get.find<DashboardController>();

  InformationSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
        child: Container(
          height: 150,
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Color.fromRGBO(226, 3, 47, 1.0),
            borderRadius: BorderRadius.all(Radius.circular(12)),
            border: Border.fromBorderSide(BorderSide(color: Colors.grey)),
            // boxShadow: [BoxShadow(blurRadius: 8,color: Colors.white,offset: Offset(1,2))]
            shape: BoxShape.rectangle,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "INFORMATION",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize:
                          Breakpoints(xs: 18.0, sm: 20.0, md: 22.0, lg: 20.0)
                              .choose(Get.width)),
                ),
              ),
              Flexible(
                  child: Container(
                      // height: double.infinity,
                      // width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        border: const Border.fromBorderSide(
                            BorderSide(color: Colors.grey)),
                        // boxShadow: [BoxShadow(blurRadius: 8,color: Colors.white,offset: Offset(1,2))]
                        shape: BoxShape.rectangle,
                      ),
                      child: ListView.builder(
                          itemCount: 3,
                          itemBuilder: (c, i) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [

                                      HtmlWidget(
                                        "The construction team has completed the foundation work for the new residential building on Main Street. Next steps include framing and installation of utilities. Stay tuned for further progress updates and milestones!",
                                        textStyle: TextStyle(
                                            fontSize: Breakpoints(
                                                    xs: 15.0,
                                                    sm: 17.0,
                                                    md: 20.0,
                                                    lg: 20.0)
                                                .choose(Get.width)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })


                      )),
            ],
          ),
        ));
  }

  getStackInformation() {
    return Stack(
      children: [
        Container(
          height: 150,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(226, 3, 47, 1.0),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20)),
            border: Border.fromBorderSide(BorderSide(color: Colors.grey)),
            // boxShadow: [BoxShadow(blurRadius: 8,color: Colors.white,offset: Offset(1,2))]
            shape: BoxShape.rectangle,
          ),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "INFORMATION",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 35, 10, 10),
          child: Container(
            height: 100,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: Border.fromBorderSide(BorderSide(color: Colors.grey)),
              // boxShadow: [BoxShadow(blurRadius: 8,color: Colors.white,offset: Offset(1,2))]
              shape: BoxShape.rectangle,
            ),
            child: Expanded(
              flex: 1,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.shade300),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Welcome to construcshare !",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
