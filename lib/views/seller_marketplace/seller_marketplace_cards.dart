// import 'dart:ffi';

 import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:construct/custom_widget/app_bar.dart';
// import 'package:construct/views/seller_marketplace/model/items.dart';
import 'package:construct/views/seller_marketplace/search_posts.dart';
import 'package:construct/views/seller_marketplace/toggle_button.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
 import 'package:responsive_toolkit/breakpoints.dart';

import '../../consts/images.dart';
import '../../controllers/seller_markerplace_controller.dart';
import 'detailScreen.dart';
import 'model/items.dart';

class SellerMarketPlaceCards extends StatefulWidget {
  bool isDashboard = false;

  SellerMarketPlaceCards({super.key,  this.isDashboard = false});
  @override
  State<SellerMarketPlaceCards> createState() => _SellerMarketPlace();
}

class _SellerMarketPlace extends State<SellerMarketPlaceCards> {
  late Widget numberPaginator;
  final NumberPaginatorController _controller = NumberPaginatorController();
  final sellerMarketplaceCtrl = Get.find<SellerMarketplaceController>();
  var _numPages = 0;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    // sellerMarketplaceCtrl.search('');
    sellerMarketplaceCtrl.getSellerMarketplace(page: 1, pageType: "all_post");
    sellerMarketplaceCtrl.setNumberCtrl(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: (widget.isDashboard
      //     ?PreferredSize(child: Container(), preferredSize:   const Size(double.infinity, kToolbarHeight))
      //     : myRedAppBar("Seller Marketplace", context)),
      appBar: myAppBar("Seller MArketplace", context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(child: __SellerMarketPlace()),
          Obx(() => getTotalPages() >= 1
              ? NumberPaginator(
            key: const Key('paginator'),
            controller: sellerMarketplaceCtrl.numberCtrl.value,
            // by default, the paginator shows numbers as center content
            numberPages: _numPages = getTotalPages(),
            onPageChange: (int index) {
              sellerMarketplaceCtrl.getSellerMarketplace(page: index + 1, pageType: sellerMarketplaceCtrl.page_type.value);
              setState(() {
                _currentPage = index + 1;
              });
            },
          )
              : Container())
        ],
      ),
    );
  }

  getTotalPages() {
    return ((sellerMarketplaceCtrl.totalCount % 20 == 0)
        ? (sellerMarketplaceCtrl.totalCount / 20)
        : ((sellerMarketplaceCtrl.totalCount / 20) + 1))
        .toInt();
  }
}

class __SellerMarketPlace extends GetView<SellerMarketplaceController> {
  final sellerMarketplaceCtrl = Get.find<SellerMarketplaceController>();
  __SellerMarketPlace({Key? key}) : super(key: key);

  RxBool sale = false.obs;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
          child: SearchPost(),
        ),

        const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // const Padding(
            //     padding: EdgeInsets.all(5.0),
            //     child: SingleChildScrollView(
            //       child: AllCategory(),
            //     )),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 4, 8, 8),
              child: SaleLeaseButtons(),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Obx(() => GridView.builder(
                itemCount: sellerMarketplaceCtrl.posts.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  // crossAxisCount: res.Device.screenType == res.ScreenType.tablet ? 3 : 2,
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 0,
                  childAspectRatio:
                  Breakpoints(xs: 0.55, sm: 0.56, md: 0.7, lg: 0.8)
                      .choose(Get.width),
                ),
                itemBuilder: (context, index) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Stack(
                    children: [
                      ItemCard(
                          product: getItem().elementAt(index),
                          // press: (){},
                          press: () => Get.to(
                                  () =>
                                      DetailsScreen(
                                product: getItem().elementAt(index),
                                tagThumbnail: getItem()
                                    .elementAt(index)
                                    .productID!,
                              ),
                              transition: Transition.leftToRight,
                              curve: Curves.easeInCubic,
                              duration: const Duration(milliseconds: 800))

                        // Navigator.push(
                        // context,
                        // MaterialPageRoute(
                        //   builder: (context) => DetailsScreen(
                        //     product: getItem().elementAt(index),
                        //   ),
                        // )),
                      ),
                      Positioned(
                        top: 15,
                        right: 0,
                        child: Transform(
                          alignment: Alignment.topRight,
                          transform:
                          scaleXYZTransform(scaleX: .75, scaleY: .75),
                          child: Container(
                            child: ClipPath(
                              clipper: ProsteThirdOrderBezierCurve(
                                list: [
                                  ThirdOrderBezierCurveSection(
                                      p1: const Offset(0, 30),
                                      p2: const Offset(0, 0),
                                      p3: const Offset(15, 20),
                                      p4: const Offset(15, 10),
                                      smooth: 0),
                                ],
                              ),
                              child: Container(
                                child: getItem().elementAt(index).type ==
                                    'sale'
                                    ? const Padding(
                                  padding: EdgeInsets.all(6.0),
                                  child: Text("Sale",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight:
                                          FontWeight.bold),
                                      textAlign: TextAlign.right),
                                )
                                    : const Padding(
                                  padding: EdgeInsets.all(6.0),
                                  child: Text("Lease",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight:
                                          FontWeight.bold),
                                      textAlign: TextAlign.right),
                                ),
                                height: 30,
                                width: 60,
                                color: getItem().elementAt(index).type ==
                                    'sale'
                                    ? const Color(0xffDC2626)
                                    : const Color(0xff0019DA),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 15,
                        left: 0,
                        child: Transform(
                          alignment: Alignment.topLeft,
                          transform:
                          scaleXYZTransform(scaleX: .75, scaleY: .75),
                          child: (getItem().elementAt(index).condition ==
                              'New'
                              ? Container(
                              child: ClipPath(
                                clipper: ProsteBezierCurve(
                                    position: ClipPosition.top,
                                    list: [
                                      BezierCurveSection(
                                        start: const Offset(80, 30),
                                        top: const Offset(80 - 10, 30),
                                        end: const Offset(80, 15),
                                      ),
                                      BezierCurveSection(
                                        start: const Offset(80, 15),
                                        top: const Offset(80 - 10, 0),
                                        end: const Offset(80, 0),
                                      ),
                                    ]),
                                child: Container(
                                  height: 30,
                                  width: 80,
                                  color: const Color(0xffFFB647),
                                  child: const Padding(
                                    padding: EdgeInsets.all(6.0),
                                    child: Text("New Item",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.left),
                                  ),
                                ),
                              ))
                              : Container()),
                        ),
                      )
                    ],
                  ),
                )
              //
            )),
          ),
        ),
      ],
    );
  }

  List<Product> getItem() {
    List<Product> p = <Product>[];
    int i = 0;
    for (var e in sellerMarketplaceCtrl.posts) {
      p.add(Product(
          id: i,
          image: e.postImg!.isNotEmpty
              ? e.postImg!.elementAt(0)
              : appLogo,
          title: e.postTitle!,
          price: e.pricing!.unitPrice!,
          description: e.description!,
          qty: e.pricing!.quantity!,
          sellerName: e.user?.name!,
          companyName: e.user?.companyName!,
          unitPrice: e.pricing!.unitPrice!,
          category: e.subcategory,
          type: e.category!,
          deliveryType: e.deliveryType!,
          dealingMethod: e.dealingMethod!,
          inStock: e.pricing!.inStock!,
          productID: "",
          from: e.availability?.from,
          to: e.availability?.to,
          expDate: e.availability?.expDate,
          userID: e.user?.sId,
          period: e.duration?.period,
          unit: e.duration?.unit,
          oid: "",
          sellerEmail: "",
          condition: e.condition,
          isNonNegotiable: e.isNonNegotiable));
    }
    return p;
  }

  Matrix4 scaleXYZTransform({
    double scaleX = 1.00,
    double scaleY = 1.00,
    double scaleZ = 1.00,
  }) {
    return Matrix4.diagonal3Values(scaleX, scaleY, scaleZ);
  }
}

class ItemCard extends StatelessWidget {
  ItemCard({Key? key, required this.product, required this.press})
      : super(key: key);

  final Product product;

  // final Function press;
  final Function() press;

  var inputFormat = DateFormat('yyyy-MM-ddTHH:mm:ssZ');
  late DateTime inputFromDate =
  inputFormat.parse(product.from.toString()); // <-- dd/MM 24H format
  final df = DateFormat('MMM dd, yyyy ');
  late String fromDate = df.format(inputFromDate);

  late DateTime inputToDate =
  inputFormat.parse(product.to.toString()); // <-- dd/MM 24H format
  late String toDate = df.format(inputToDate);

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
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: SizedBox(
                        height: 110,
                        child: Hero(
                          tag: product.productID!,
                          child: Image.asset(
                                product.image!,
                                height: double.infinity),

                        ),
                      ),
                    ),
                    const Divider(color: Colors.grey),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                      child: Text(
                        // products is out demo list
                        product.productID!,
                        style:
                        const TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                      child: AutoSizeText(
                        product.title!,
                        // style: TextStyle(fontSize: 30),
                        minFontSize: 10,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              product.sellerName ?? "",
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                          const Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 20,
                              ),
                              Text(
                                "N/A",
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                      child: Text(
                        // products is out demo list
                        product.companyName ?? "",
                        style:
                        const TextStyle(color: Colors.black, fontSize: 12),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            // products is out demo list
                            "Unit Price",
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                          Text(
                            // products is out demo list
                            "SGD " + '${product.unitPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                                color: Colors.red, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            // products is out demo list
                            "Quantity",
                            style: TextStyle(
                                color: Colors.black, fontSize: 12),
                          ),
                          Text(
                            // products is out demo list
                            '${product.qty}',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    (product.type == "lease"
                        ? Padding(
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            // products is out demo list
                            "Availability",
                            style: TextStyle(
                                color: Colors.black, fontSize: 11),
                          ),
                          Column(
                            children: [
                              Text(
                                // products is out demo list
                                fromDate + " to",
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 11),
                              ),
                              Text(
                                // products is out demo list
                                toDate,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 11),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                        : Container())
                  ],
                ),
              ),
            ),
          ],
        ));
  }
  
}
