import 'package:construct/consts/colors.dart';
import 'package:construct/custom_widget/app_bar.dart';
import 'package:construct/views/dashboard/dashboard.dart';
import 'package:construct/views/help_desk/help_desk_screen.dart';
 import 'package:construct/views/notifications/notification_screen.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:construct/custom_widget/drawer.dart' as nav;
import 'package:badges/badges.dart' as badge;
import 'package:get/get.dart';

import '../../controllers/dashboard_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late int currentPage;
  final dashboardCtrl = Get.put(DashboardController());

  late TabController tabController;


  @override
  void initState() {
    currentPage = 0;
    tabController = TabController(length: 3, vsync: this);
    tabController.animation?.addListener(
      () {
        final value = tabController.animation!.value.round();
        if (value != currentPage && mounted) {
          changePage(value);
        }
      },
    );
    super.initState();
  }

  void changePage(int newPage) {
    setState(() {
      currentPage = newPage;
    });
  }

  @override
  Widget build(BuildContext context) {

    const Color unselectedColor = Colors.black;

    return SafeArea(

      child: Scaffold(
        appBar: myDashboardAppBar(),
        drawer: nav.NavigationDrawer(),
        body: BottomBar(
          clip: Clip.none,
          fit: StackFit.expand,
          icon: (width, height) => Center(
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: null,
              icon: Icon(
                Icons.arrow_upward_rounded,
                color: unselectedColor,
                size: width,
              ),
            ),
          ),
          borderRadius: BorderRadius.circular(500),
          duration: const Duration(milliseconds: 500),
          curve: Curves.decelerate,
          showIcon: true,
          width: MediaQuery.of(context).size.width * 0.8,
          barColor: Colors.white,
          start: 2,
          end: 0,
          offset: 10,
          barAlignment: Alignment.bottomCenter,
          iconHeight: 30,
          iconWidth: 30,
          reverse: false,
          barDecoration: BoxDecoration(
            color: appColor,
            borderRadius: BorderRadius.circular(500),
          ),
          iconDecoration: BoxDecoration(
            color: appColor,
            borderRadius: BorderRadius.circular(500),
          ),
          hideOnScroll: true,
          scrollOpposite: false,
          onBottomBarHidden: () {},
          onBottomBarShown: () {},
          body: getBody,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              TabBar(
                indicatorPadding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                controller: tabController,
                indicator: const UnderlineTabIndicator(
                    borderSide: BorderSide(
                      color: appColor,
                      width: 4,
                    ),
                    insets: EdgeInsets.fromLTRB(16, 0, 16, 8)),
                tabs: [
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: Center(
                        child: Icon(
                          Icons.home,
                          color: currentPage == 0 ? appColor : unselectedColor,
                        )),
                  ),


                  badge. Badge(
                    badgeStyle: const badge.BadgeStyle(
                      shape: badge.BadgeShape.square,
                      badgeColor: appColor,
                      borderRadius:
                      BorderRadius.all(Radius.circular(5)),
                    ),
                    badgeAnimation: const badge.BadgeAnimation.scale(),
                     showBadge:true ,
                     position: badge.BadgePosition.topEnd(top: 2, end: -24),
                     badgeContent: const Text(
                      "40",
                      style: TextStyle(color: Colors.white),
                    ),
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: Center(
                          child: Icon(
                            Icons.notifications_on_outlined,
                            color: currentPage == 1 ? appColor : unselectedColor,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: Center(
                        child: Icon(
                          Icons.headset_mic_outlined,
                          color: currentPage == 2 ? appColor : unselectedColor,
                        )),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
  Widget getBody(BuildContext context, ScrollController controller) {
    switch (currentPage) {
      case 0:
        dashboardCtrl.currentPageName('Dashboard');
        return const DashboardScreen();
      case 1:
        dashboardCtrl.currentPageName('Notifications');
        return const NotificationScreen();
      case 2:
        dashboardCtrl.currentPageName('Help Desk');
        return const HelpDeskScreen(
         );
    }
    return Container();
  }
}
