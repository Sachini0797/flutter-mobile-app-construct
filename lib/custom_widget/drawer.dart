import 'package:construct/consts/colors.dart';
import 'package:construct/consts/images.dart';
import 'package:construct/views/buyer_forum/buyer_forum_cards.dart';
import 'package:construct/views/dashboard/dashboard.dart';
import 'package:construct/views/seller_marketplace/seller_marketplace_cards.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badge;
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../views/create_posts/create_post_form.dart';

class NavigationDrawer extends StatelessWidget {
    NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget> [

            buildHeader(context),
            buildMenuItems(context)
          ],
        ),
      ),
    );
  }
  SampleItem? selectedMenu;

  Widget buildHeader (BuildContext context) => Material(
    color: appColor,
    child: Container(
      padding: const EdgeInsets.only(top: 35),
      child: Column(
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            height: 80,
            width: 80,
            decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(100))),
            child: Image.asset(
              user,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          const Text("Mark Anthony",
            style: TextStyle(fontSize: 28, color: Colors.white),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              PopupMenuButton<SampleItem>(
                icon: const Icon(Icons.more_vert_rounded, color: Colors.white,),
                initialValue: selectedMenu,
                onSelected: (SampleItem item){
                  selectedMenu = item;
                  if(item == SampleItem.itemOne){

                  }
                  if(item == SampleItem.itemTwo){

                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
                  const PopupMenuItem<SampleItem>(
                    value: SampleItem.itemOne,
                    child: Text("Profile"),
                  ),
                  const PopupMenuItem<SampleItem>(
                    value: SampleItem.itemOne,
                    child: Text("Change password"),
                  )
                ],
              )
            ],
          )
        ],
      ),
    ),
  );
  Widget buildMenuItems(BuildContext context) => Container(
    padding: const EdgeInsets.all(10),
    child: Wrap(
      runSpacing: 1,
      children: [
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title: const Text("Dashboard"),
          onTap: () {
            Navigator.pushAndRemoveUntil<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => const DashboardScreen(),
              ),
                  (route) => false,//if you want to disable back feature set to false
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.event_note),
          title: const Text("Seller Marketplace"),
          onTap: () {
            Navigator.pop(context);

            Get.to(() =>   SellerMarketPlaceCards(),
                transition: Transition.leftToRight,
                curve: Curves.easeInCubic,
                duration: const Duration(milliseconds: 800));

          },
        ),
        ListTile(
          leading: const Icon(Icons.bar_chart),
          title: const Text("Buyer Forum"),
          onTap: () {
            Navigator.pop(context);
            Get.to(() =>   BuyerForum(),
                transition: Transition.leftToRight,
                curve: Curves.easeInCubic,
                duration: const Duration(milliseconds: 800));
          },
        ),
        badge.Badge(
          position: badge.BadgePosition.topEnd(top: 12, end: 2),
          badgeContent: const Text(
            "10",
            style: TextStyle(color: Colors.white),
          ),
          showBadge: true,
          child: ListTile(
            leading: const Icon(Icons.inbox_outlined),
            title: const Text("Inbox"),
            onTap: () {
              Navigator.pop(context);


            },
          ),
        ),
        const Row(children: <Widget>[
          Expanded(child: Divider()),
          Text(
            "Create",
            style: TextStyle(color: Colors.grey),
          ),
          Expanded(child: Divider()),
        ]),
        ListTile(
          leading: const Icon(Icons.local_shipping_outlined),
          title: const Text("Sale/Lease Post"),
          onTap: () {
            Navigator.pop(context);
            Get.to(() =>   CreatePostPage('SALE', false, false),
                transition: Transition.leftToRight,
                curve: Curves.easeInCubic,
                duration: const Duration(milliseconds: 800));

          },
        ),
        ListTile(
          leading: const Icon(Icons.description),
          title: const Text("Buyer Request"),
          onTap: () {
            Navigator.pop(context);

          },
        ),
        const Row(children: <Widget>[
          Expanded(child: Divider()),
          Text(
            "View My Items",
            style: TextStyle(color: Colors.grey),
          ),
          Expanded(child: Divider()),
        ]),
        ListTile(
          leading: const Icon(Icons.post_add_outlined),
          title: const Text("Post"),
          onTap: () {
            Navigator.pop(context);


          },
        ),
        ListTile(
          leading: const Icon(Icons.drafts_outlined),
          title: const Text("Draft"),
          onTap: () {
            Navigator.pop(context);


          },
        ),
        ListTile(
          leading: const Icon(Icons.request_page_outlined),
          title: const Text("Request"),
          onTap: () {
            Navigator.pop(context);

          },
        ),
        const Row(children: <Widget>[
          Expanded(child: Divider()),
          Text(
            "Orders",
            style: TextStyle(color: Colors.grey),
          ),
          Expanded(child: Divider()),
        ]),
        ListTile(
          leading: Image.asset(
            "assets/images/dashboard_icons/PendingTransaction.png",
            height: 20,
            width: 20,
          ),
          title: const Text("Pending Transaction"),
          onTap: () {
            Navigator.pop(context);

          },
        ),
        ListTile(
          leading: Image.asset(
            "assets/images/dashboard_icons/completed.png",
            height: 20,
            width: 20,
          ),
          title: const Text("Completed Orders"),
          onTap: () {
            Navigator.pop(context);

          },
        ),ListTile(
          leading: Image.asset(
            "assets/images/dashboard_icons/Unsuccessful.png",
            height: 20,
            width: 20,
          ),
          title: const Text("Unsuccessful Orders"),
          onTap: () {
            Navigator.pop(context);

          },
        ),


        const Divider(
          color: Colors.grey,
        ),
        ListTile(
          leading: const Icon(Icons.people_alt_outlined),
          title: const Text("User Follow"),
          onTap: () {
            Navigator.pop(context);


          },
        ),
        ListTile(
          leading: const Icon(Icons.reviews_outlined),
          title: const Text("Reviews"),
          onTap: () {
            Navigator.pop(context);

          },
        ),
        ListTile(
          leading: const Icon(Icons.update_outlined),
          title: const Text("Performance"),
          onTap: () {
            Navigator.pop(context);

          },
        ),
        ListTile(
          leading: const Icon(Icons.headset_mic_outlined),
          title: const Text("Help Desk"),
          onTap: () {
            Navigator.pop(context);

          },
        ),
        ListTile(
          leading: const Icon(Icons.logout_outlined),
          title: const Text("Log Out"),
          onTap: () {

          },
        ),

      ],
    ),
  );
}
enum SampleItem { itemOne, itemTwo }

