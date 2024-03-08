
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:construct/consts/colors.dart';
import 'package:construct/consts/images.dart';
import 'package:construct/custom_widget/app_bar.dart';
import 'package:construct/utils/standart_dates_format.dart';
import 'package:construct/views/seller_marketplace/model/items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';

import '../../controllers/seller_markerplace_controller.dart';
import 'confirm_price_button.dart';



class DetailsScreen extends StatelessWidget {
  final Product product;
  final String tagThumbnail;
  const DetailsScreen({Key? key, required this.product,required this.tagThumbnail}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // each product have a color
      backgroundColor: Colors.white,
      appBar: myAppBar("", context),
      body: DetailBody(product: product,tagThumbnail:tagThumbnail),
    );
  }
}

class DetailBody extends StatelessWidget {
  final sellerMarketplaceCtrl = Get.find<SellerMarketplaceController>();
  // final myFollowings = Get.find<FollowingController>();
  // final inboxCtrl = Get.find<InboxController>();
  final confirmPriceFormKey = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();
  final Product product;
  final String tagThumbnail;

  DetailBody({Key? key, required this.product,required this.tagThumbnail}) : super(key: key);
  late bool negotitate = true;
  int? enteredConfirmPriceQuantity;
  int? enteredQuantity;
  double? offeredPrice;
  String? dd = "dsa";
  var confirmPriceQuantityInput = TextEditingController();

  var tot = TextEditingController();

  var dragScrlCtrl = DraggableScrollableController();
  RxBool isFollowing = false.obs;
  RxBool isF = false.obs;
  Matrix4 scaleXYZTransform({
    double scaleX = 1.00,
    double scaleY = 1.00,
    double scaleZ = 1.00,
  }) {
    return Matrix4.diagonal3Values(scaleX, scaleY, scaleZ);
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(
            child: Container(
                margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     

                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                            
                            },
                            child: Row(
                              children: [
                                (Obx(() => Icon(
                                  isFollowing.isTrue ? Icons.person_remove_outlined : Icons.person_add_outlined,
                                  size: 18,
                                  color: !isFollowing.isTrue ? Colors.green : Colors.red,
                                ))),
                                (Obx(() => Text(
                                  // 'Unfollow',
                                  isFollowing.isTrue ? ' Unfollow' : ' Follow',
                                  style: TextStyle(color: !isFollowing.isTrue ? Colors.green : Colors.red),
                                )))
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(product.companyName!, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.red)),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "#" +"7363543nfh7",
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                    child: Column(
                      children: [
                        Hero(
                          tag: tagThumbnail,
                          child:

                         
                                Image.asset(product.image!),
                          // ),
                        ), // <-- SEE HERE
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      Flex(
                        direction: Axis.vertical,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.transparent, // Set border color
                                      width: 3.0), // Set border width
                                  borderRadius: const BorderRadius.all(Radius.circular(10.0)), // Set rounded corner radius
                                  boxShadow: const [BoxShadow(blurRadius: 10, color: Colors.grey, offset: Offset(1, 3))] // Make rounded corner of border
                              ),
                              child: Container(
                                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: Column(
                                    children: [
                                      (product.type == 'sale' && product.condition == 'New Item'
                                          ? Row(
                                        mainAxisAlignment : MainAxisAlignment.start,
                                        children: [
                                          Container(
                                              child: ClipPath(
                                                clipper: ProsteBezierCurve(position: ClipPosition.top, list: [
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
                                                    child: Text("New Item", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.left),
                                                  ),
                                                ),
                                              )),
                                        ],
                                      )
                                          : Container()),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              product.title!,
                                              style: const TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'Category: ',
                                            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            product.category!,
                                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          const Text(
                                            "Type of this post",
                                            style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                            height: 35,
                                            decoration: BoxDecoration(
                                              color: const Color(0xffEBEBEB),
                                              border: Border.all(
                                                  color: Colors.transparent, // Set border color
                                                  width: 3.0), // Set border width
                                              borderRadius: const BorderRadius.all(Radius.circular(10.0)), // Set rounded corner radius
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                                              child: Text(product.type!, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Row(
                                        children: [
                                          Text(
                                            "Description",
                                            style: TextStyle(color: Colors.grey, fontSize: 17, fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                                product.description!,
                                                style: const TextStyle(fontWeight: FontWeight.bold),
                                              ))
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xffEBEBEB),
                                          border: Border.all(
                                              color: Colors.transparent, // Set border color
                                              width: 3.0), // Set border width
                                          borderRadius: const BorderRadius.all(Radius.circular(1.0)), // Set rounded corner radius
                                        ),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  const Text(
                                                    "Delivery Type",
                                                    style: TextStyle(fontWeight: FontWeight.w600),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                  Text(
                                                    product.deliveryType!,
                                                    style: const TextStyle(fontWeight: FontWeight.w500),
                                                    textAlign: TextAlign.end,
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  const Text(
                                                    "Dealing Method",
                                                    style: TextStyle(fontWeight: FontWeight.w600),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                  Text(
                                                    product.dealingMethod!,
                                                    style: const TextStyle(fontWeight: FontWeight.w500),
                                                    textAlign: TextAlign.end,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            (product.type == "lease"
                                                ? Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  const Text(
                                                    "Availability",
                                                    style: TextStyle(fontWeight: FontWeight.w600),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        // products is out demo list
                                                        product.from.toString().toStandardDate() + " to ",
                                                        style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600),
                                                      ),
                                                      Text(
                                                        // products is out demo list
                                                        product.to.toString().toStandardDate(),
                                                        style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                                : Container()),
                                            (product.type == "lease"
                                                ? (product.period != null
                                                ? Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  const Text(
                                                    "Lease Period (Minimum)",
                                                    style: TextStyle(fontWeight: FontWeight.w600),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        '${product.period}',
                                                        style: const TextStyle(fontWeight: FontWeight.w500),
                                                        textAlign: TextAlign.end,
                                                      ),
                                                      Text(
                                                        " ${product.unit == null ? '' : product.unit.toString()}",
                                                        style: const TextStyle(fontWeight: FontWeight.w500),
                                                        textAlign: TextAlign.end,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                                : Container())
                                                : Container())
                                          ],
                                        ),
                                      ),
                                      (product.type == "sale"
                                          ? Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[

                                               Row(
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.all(3.0),
                                                child: Text(
                                                  "Quantity: ",
                                                  style: TextStyle(fontWeight: FontWeight.w600),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                              Text(
                                                '${product.qty}',
                                                style: const TextStyle(fontWeight: FontWeight.w600),
                                                textAlign: TextAlign.start,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                "Unit Price: ",
                                                style: TextStyle(fontWeight: FontWeight.w600),
                                                textAlign: TextAlign.start,
                                              ),
                                              Text(
                                                "SGD " + "${product.unitPrice}",
                                                style: const TextStyle(fontWeight: FontWeight.w600),
                                                textAlign: TextAlign.start,
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                          :Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Quantity",
                                              style: TextStyle(fontWeight: FontWeight.w600),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '${product.qty}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      )
                                          ),
                                      (product.type == "lease"
                                          ? Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: const Color(0xffEBEBEB),
                                            border: Border.all(
                                                color: Colors.transparent, // Set border color
                                                width: 3.0), // Set border width
                                            borderRadius: const BorderRadius.all(Radius.circular(1.0)), // Set rounded corner radius
                                          ),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(5),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    const Text(
                                                      "Unit Price (per day)",
                                                      style: TextStyle(fontWeight: FontWeight.w600),
                                                      textAlign: TextAlign.start,
                                                    ),
                                                    Text(
                                                      "SGD " + '${product.unitPrice.toStringAsFixed(2)}',
                                                      style: const TextStyle(fontWeight: FontWeight.w500),
                                                      textAlign: TextAlign.end,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                          : Container()),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "In Stock: ",
                                              style: TextStyle(fontWeight: FontWeight.w600),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '${product.inStock}',
                                              style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.red),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.fromLTRB(5, 20, 5, 5),
                          //   child: Container(
                          //     width: double.infinity,
                          //     decoration: BoxDecoration(
                          //         color: Colors.white,
                          //         border: Border.all(
                          //             color: Colors.transparent, // Set border color
                          //             width: 3.0), // Set border width
                          //         borderRadius: const BorderRadius.all(Radius.circular(10.0)), // Set rounded corner radius
                          //         boxShadow: [const BoxShadow(blurRadius: 10, color: Colors.grey, offset: Offset(1, 3))] // Make rounded corner of border
                          //     ),
                          //     child: Container(
                          //         padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                          //         child: Row(
                          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //           children: [
                          //             MaterialButton(
                          //               minWidth: 150,
                          //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                          //               elevation: 6,
                          //               onPressed: () {
                          //
                          //               },
                          //               child: const Text(
                          //                 "EDIT",
                          //                 style: TextStyle(color: Colors.white),
                          //               ),
                          //               color: Colors.amber,
                          //             ),
                          //             MaterialButton(
                          //               minWidth: 150,
                          //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                          //               elevation: 6,
                          //               onPressed: () {
                          //                 getShowBottomSheet(_BuildBottomSheet);
                          //               },
                          //               child: const Text(
                          //                 "DELETE",
                          //                 style: TextStyle(color: Colors.white),
                          //               ),
                          //               color: const Color(0xffE4032F),
                          //             ),
                          //           ],
                          //         )),
                          //   ),
                          // ),
                              Padding(
                            padding: const EdgeInsets.fromLTRB(5, 20, 5, 5),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.transparent, // Set border color
                                      width: 3.0), // Set border width
                                  borderRadius: const BorderRadius.all(Radius.circular(10.0)), // Set rounded corner radius
                                  boxShadow: [const BoxShadow(blurRadius: 10, color: Colors.grey, offset: Offset(1, 3))] // Make rounded corner of border
                              ),
                              child: Container(
                                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              product.title!,
                                              style: const TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      ConfirmPriceButton(
                                        product: product,
                                      ),

                                      MaterialButton(
                                        minWidth: 150,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                                        elevation: 6,
                                        onPressed: () {

                                        },
                                        child: const Text(
                                          "CHAT",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        color: const Color(0xffE4032F),
                                      ),
                                    ],
                                  )),
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ])),
          )
        ],
      ),
    );
  }

  getShowBottomSheet(sheet) {
    showFlexibleBottomSheet(
        minHeight: 0,
        initHeight: 0.20,
        maxHeight: .20,
        bottomSheetColor: Colors.transparent,
        barrierColor: const Color.fromARGB(120, 0, 0, 0),
        context: Get.context!,
        draggableScrollableController: dragScrlCtrl,
        builder: sheet,
        isExpand: true,
        isSafeArea: true,
        decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            )));
  }

   Widget _BuildBottomSheet(
      BuildContext context,
      ScrollController scrollController,
      double bottomSheetOffset,
      ) {
    return Material(
      elevation: 4,
      shadowColor: const Color.fromARGB(150, 0, 0, 0),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: Colors.transparent, // Set border color
                  width: 3.0), // Set border width
              borderRadius: const BorderRadius.all(Radius.circular(10.0)), // Set rounded corner radius
              boxShadow: [const BoxShadow(blurRadius: 10, color: Colors.grey, offset: Offset(1, 3))] // Make rounded corner of border
          ),
          child: ListView(
            controller: scrollController,
            shrinkWrap: true,
            children: [
              const Center(
                child: Column(
                  children: [
                    Text(
                      "Want to delete?",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text("Do you really want to proceed?"),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: MaterialButton(
                        minWidth: 200,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        elevation: 6,
                        onPressed: () {



                              const GetSnackBar(
                                title: '',
                                message: 'Successfully Deleted',
                                backgroundColor: appColor,
                                duration: Duration(seconds: 7),
                              ).show();
                              Navigator.pop(context);

                        },
                        textColor: Colors.white,
                        color: const Color(0xffE4032F),
                        child: const Text('YES'),
                      )),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                      child: MaterialButton(
                        minWidth: 200,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        elevation: 6,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: Colors.grey,
                        textColor: Colors.white,
                        child: const Text('CANCEL'),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
