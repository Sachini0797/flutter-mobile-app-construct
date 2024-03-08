
import 'package:construct/views/dashboard/create_section.dart';
import 'package:construct/views/dashboard/dashboard_cards.dart';
import 'package:construct/views/dashboard/information_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'action_menu.dart';


class DashboardScreen extends StatelessWidget {
  const DashboardScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xffe20330),
        body:
        ListView(
          shrinkWrap: true,
          children: [
            ActionMenu(),
            CreateSection(),
            InformationSection(),
            DashboardCards()






            ],)


    );
  }
}
