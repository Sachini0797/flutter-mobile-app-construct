import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:construct/custom_widget/app_bar.dart';
import 'package:construct/models/buyer_forum_model.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_paginator/number_paginator.dart';

import '../../controllers/buyer_forum_controller.dart';

class BuyerForum extends StatefulWidget {
  @override
  State<BuyerForum> createState() => _BuyerForum();
}

class _BuyerForum extends State<BuyerForum> {
  final buyerForumCtrl = Get.find<BuyerForumController>();
   int _numPages = 0;
  int _currentPage = 0;

  @override
  void initState() {

    buyerForumCtrl.getBuyerForum(page: 1,);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: myAppBar("Buyer Forum", context),
        body: Column(
          children: [
            Flexible(
              child: GetXBuyerForum(),
            ),
            Obx(() => getTotalPages() >= 1
                ? NumberPaginator(
              key: const Key('paginator'),
              controller: buyerForumCtrl.numberCtrl.value,
              // by default, the paginator shows numbers as center content
              numberPages: _numPages = getTotalPages(),
              onPageChange: (int index) {
                buyerForumCtrl.getBuyerForum(page: index + 1);
                if (mounted)
                  setState(() {
                    _currentPage = index + 1;
                  });
              },
            )
                : Container())
          ],
        ));
  }

  getTotalPages() {
    return ((buyerForumCtrl.totalCount % 20 == 0) ? (buyerForumCtrl.totalCount / 20) : ((buyerForumCtrl.totalCount / 20) + 1)).toInt();
  }
}

class GetXBuyerForum extends StatelessWidget {
  final buyerForumCtrl = Get.find<BuyerForumController>();

  GetXBuyerForum({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _numPages = 0;
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.topCenter,
      children: [
        //   Flexible(child:
        // )

        Padding(
          padding: const EdgeInsets.fromLTRB(10, 140, 10, 10),
          child: Obx(() => GridView.builder(
              itemCount: buyerForumCtrl.entries.value.length,
              gridDelegate:   const SliverGridDelegateWithFixedCrossAxisCount(
                // crossAxisCount: res.Device.screenType== res.ScreenType.tablet  ? 3:2,
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                // childAspectRatio: res.Device.screenType== res.ScreenType.tablet  ?0.8: 0.7 ,
                childAspectRatio: 0.6 ,
              ),
              itemBuilder: (context, index) => ItemCard(
                buyerForumRequest: buyerForumCtrl.entries.elementAt(index),
                press: (){},

              )
            //
          )),
        ),

      ],
    );
  }

}

class ItemCard extends StatelessWidget {
  const ItemCard({Key? key, required this.buyerForumRequest, required this.press}) : super(key: key);

  final Entries buyerForumRequest;

  // final Function press;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: press,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(0),
                // height: 180,
                // width: 160,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          buyerForumRequest.types!.contains('rent')
                              ? Row(
                            children: [
                              const Icon(
                                Icons.circle,
                                color: Colors.red,
                                size: 15,
                              ),
                              Text((buyerForumRequest.types!.singleWhere((element) => element == 'rent')))
                            ],
                          )
                              : Container(),
                          buyerForumRequest.types!.contains('purchase')
                              ? Row(
                            children: [
                              const Icon(
                                Icons.circle,
                                color: Colors.blue,
                                size: 15,
                              ),
                              Text((buyerForumRequest.types!.singleWhere((element) => element == 'purchase'))),
                            ],
                          )
                              : Container(),
                        ],
                      ),
                    ),
                    const Divider(color: Colors.grey),
                    Center(
                      child: Container(
                        height: 110,
                        child:
                        Image.asset(buyerForumRequest.images!.first, height: double.infinity)

                      ),
                    ),
                    const Divider(color: Colors.grey),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                      child: Text(
                        // products is out demo list
                        buyerForumRequest.title!,
                        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Category:"),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text(
                              buyerForumRequest.category!,
                              style: const TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
