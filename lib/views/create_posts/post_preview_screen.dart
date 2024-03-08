import 'dart:convert';
import 'dart:io';

 import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:construct/consts/colors.dart';
import 'package:construct/utils/standart_dates_format.dart';
import 'package:construct/views/create_posts/product_model.dart';
import 'package:construct/views/home_screen/home_screen.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../consts/images.dart';
import '../../custom_widget/app_bar.dart';
import 'create_post_form.dart';



class PostPreviewPage extends StatelessWidget {
  PostPreviewPage({Key? key, required this.productDetails}) : super(key: key);
  // final createPostCtrl = Get.find<CreatePostsController>();
  RxBool isConfirmed = false.obs;

  ProductDetails productDetails;
  RxBool isDraftYes = false.obs;

  platformFee() {
    double unit_beforegst = productDetails.unitPrice ?? (productDetails.unitPrice - (productDetails.unitPrice * 0) / 100) ?? 0;
    double unit_gst = productDetails.unitPrice ?? ((productDetails.unitPrice * 0) / 100) ?? 0;
    return (unit_beforegst * (4 / 100)).toStringAsFixed(2);
  }

  totalItemPrice() {
    double totalItemPrice = productDetails.unitPrice * productDetails.quantity;
    return totalItemPrice.toStringAsFixed(2);
  }

  totalExpectedRevenur() {
    double totalItemPrice = productDetails.unitPrice * productDetails.quantity;
    double total_gst = ((productDetails.unitPrice * 0) / 100);
    double unit_beforegst = productDetails.unitPrice ?? (productDetails.unitPrice - (productDetails.unitPrice * 0) / 100) ?? 0;
    double totalExpected = (totalItemPrice - total_gst - unit_beforegst * (4 / 100) * productDetails.quantity);
    return totalExpected.toStringAsFixed(2);
  }

  totalPlatformFee() {
    double unit_beforegst = productDetails.unitPrice ?? (productDetails.unitPrice - (productDetails.unitPrice * 0) / 100) ?? 0;
    double totalPF = (unit_beforegst * (4 / 100) * productDetails.quantity);
    return totalPF.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: myAppBar("Post Confirmation", context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: Container(
                margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Preview", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                    child: Column(
                      children: [

                        (productDetails.image.isNotEmpty
                            ? CachedNetworkImage(
                          height: 100,
                          width: 100,
                          fit: BoxFit.contain,
                          imageUrl: productDetails.image.first.toString(),
                        )
                            : Image.asset(appLogo))
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                        child: Container(
                          height: 800,
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
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Column(
                              children: [
                                (productDetails.category == 'sale' ? Row(
                                  children: [
                                    Text(
                                      productDetails.condition,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ) : Container() ),

                                Row(
                                  children: [
                                    Text(
                                      productDetails.postTitle,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      child: RichText(
                                        text: TextSpan(text: 'Category: ', style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold), children: <TextSpan>[
                                          TextSpan(
                                            text: productDetails.subcategory,
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          )
                                        ]),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: <Widget>[
                                    const Expanded(
                                      child: Text(
                                        "Type of this post",
                                        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 35,
                                        decoration: BoxDecoration(
                                          color: const Color(0xffEBEBEB),
                                          border: Border.all(
                                              color: Colors.transparent, // Set border color
                                              width: 3.0), // Set border width
                                          borderRadius: const BorderRadius.all(Radius.circular(10.0)), // Set rounded corner radius
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                          child: Text(productDetails.category == 'sale' ? 'Sale' : 'Lease', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                                        ),
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
                                    Text(
                                      productDetails.description,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
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
                                      Row(
                                        children: <Widget>[
                                          const Expanded(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(right: 3),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "Delivery Type",
                                                              style: TextStyle(fontWeight: FontWeight.w600),
                                                              textAlign: TextAlign.start,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          Expanded(
                                              child: Column(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          Text(
                                                            productDetails.deliveryType == "self-collect" ? "Self Collect" : "On Site Delivery",
                                                            style: const TextStyle(fontWeight: FontWeight.w500),
                                                            textAlign: TextAlign.end,
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ))
                                        ],
                                      ),
                                      const SizedBox(height: 10),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          const Text(
                                            "Dealing Method",
                                            style: TextStyle(fontWeight: FontWeight.w600),
                                            textAlign: TextAlign.start,
                                          ),
                                          Text(
                                            productDetails.dealingMethod,
                                            style: const TextStyle(fontWeight: FontWeight.w500),
                                            textAlign: TextAlign.end,
                                          )
                                        ],
                                      ),
                                      (productDetails.category == 'lease'
                                          ? Row(
                                        children: <Widget>[
                                          const Expanded(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(right: 0.0),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "Availability",
                                                              style: TextStyle(fontWeight: FontWeight.w600),
                                                              textAlign: TextAlign.start,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          Expanded(
                                              child: Column(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.fromLTRB(0, 5, 5, 0),
                                                            child: Text(
                                                              '${productDetails.fromDate}'.toStandardDateForDateTimePicker(),
                                                              style: const TextStyle(fontWeight: FontWeight.w500),
                                                              textAlign: TextAlign.end,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.fromLTRB(0, 0, 5, 10),
                                                            child: Text(
                                                              "to " + '${productDetails.toDate}'.toStandardDateForDateTimePicker(),
                                                              style: const TextStyle(fontWeight: FontWeight.w500),
                                                              textAlign: TextAlign.end,
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ))
                                        ],
                                      )
                                          : Container()),
                                      (productDetails.category == 'lease' && productDetails.checkNA == false
                                          ? Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          const Text(
                                            "Lease Period (Minimum)",
                                            style: TextStyle(fontWeight: FontWeight.w600),
                                            textAlign: TextAlign.start,
                                          ),
                                          Text(
                                            productDetails.period + " " + productDetails.weekOrDays,
                                            style: const TextStyle(fontWeight: FontWeight.w500),
                                            textAlign: TextAlign.end,
                                          )
                                        ],
                                      )
                                          : Container()),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                (productDetails.category == 'sale'
                                    ? Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            const Text(
                                              "Quantity:",
                                              style: TextStyle(fontWeight: FontWeight.w600),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '${productDetails.quantity}',
                                              style: const TextStyle(fontWeight: FontWeight.w600),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Unit Price: SGD " + '${productDetails.unitPrice.toStringAsFixed(2)}',
                                              style: const TextStyle(fontWeight: FontWeight.w500),
                                              textAlign: TextAlign.end,
                                            ),
                                          ],
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
                                          "Platform Fee",
                                          style: TextStyle(),
                                          textAlign: TextAlign.start,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "SGD" + '${platformFee()}',
                                              style: const TextStyle(fontWeight: FontWeight.w500),
                                              textAlign: TextAlign.end,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                )
                                    : Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Quantity:",
                                      style: TextStyle(fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.start,
                                    ),
                                    Text(
                                      '${productDetails.quantity}',
                                      style: const TextStyle(fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                )),
                                const SizedBox(
                                  height: 10,
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
                                      (productDetails.category == 'sale'
                                          ? Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "Total Item Price",
                                                style: TextStyle(fontWeight: FontWeight.w600),
                                                textAlign: TextAlign.start,
                                              ),
                                              Text(
                                                "SGD " + '${totalItemPrice()}',
                                                style: const TextStyle(fontWeight: FontWeight.w500),
                                                textAlign: TextAlign.end,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "Total Expected Revenue",
                                                style: TextStyle(fontWeight: FontWeight.w600),
                                                textAlign: TextAlign.start,
                                              ),
                                              Text(
                                                "SGD " + '${totalExpectedRevenur()}',
                                                style: const TextStyle(fontWeight: FontWeight.w500),
                                                textAlign: TextAlign.end,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "Total Platform Fee",
                                                textAlign: TextAlign.start,
                                              ),
                                              Text(
                                                "SGD " + '${totalPlatformFee()}',
                                                style: const TextStyle(fontWeight: FontWeight.w500),
                                                textAlign: TextAlign.end,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                        ],
                                      )
                                          : Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "Unit Price (per day)",
                                                style: TextStyle(fontWeight: FontWeight.w600),
                                                textAlign: TextAlign.start,
                                              ),
                                              Text(
                                                "SGD " + '${productDetails.unitPrice.toStringAsFixed(2)}' + " /day",
                                                style: const TextStyle(fontWeight: FontWeight.w500),
                                                textAlign: TextAlign.end,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "Platform Fee",
                                                textAlign: TextAlign.start,
                                              ),
                                              Text(
                                                "SGD " + '${platformFee()}',
                                                style: const TextStyle(fontWeight: FontWeight.w500),
                                                textAlign: TextAlign.end,
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  children: [
                                    Obx(() => MaterialButton(
                                      minWidth: 300,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                                      elevation: 6,
                                      onPressed: () {
                                        if (isConfirmed.isTrue) {
                                          return;
                                        }

                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return ConfirmDialog();
                                            });
                                        isConfirmed(true);

                                      },
                                      child: const Text('CONFIRM & SUBMIT'),
                                      color: isConfirmed.isTrue? Colors.grey : const Color(0xffE4032F),
                                      textColor: Colors.white,
                                    )),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Obx(() => MaterialButton(
                                      minWidth: 300,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                                      elevation: 6,
                                      onPressed: () {
                                        if(isDraftYes.isTrue){
                                          return ;
                                        }
                                        if(isConfirmed.isTrue){
                                          return ;
                                        }
                                        const GetSnackBar(
                                          title: '',
                                          message: 'Successfully Save to Draft',
                                          backgroundColor: appColor,
                                          duration: Duration(seconds: 7),
                                        ).show();

                                      },
                                      child: const Text('SAVE AS DRAFT'),
                                      color: isConfirmed.isTrue || isDraftYes.isTrue ? Colors.grey.shade300 : Colors.black,
                                      textColor: Colors.white,
                                    )),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Material(
                                      child: TextButton(onPressed: () {}, child: const Text("Terms & Conditions")),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ConfirmDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 300,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                child: Column(
                  children: [

                    const Text(
                      "Thank You",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Your Post has been Listed!",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      minWidth: 220,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                      elevation: 6,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePostPage('SALE', false, false,)));
                      },
                      child: const Text(
                        "POST ANOTHER",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: const Color(0xffE4032F),
                    ),
                    MaterialButton(
                      minWidth: 220,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                      elevation: 6,
                      onPressed: () {
                        Navigator.pushAndRemoveUntil<dynamic>(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) => const HomeScreen(),
                          ),
                              (route) => false,//if you want to disable back feature set to false
                        );
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardPage()));
                      },
                      child: const Text(
                        "NO, BACK TO DASHBOARD",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: -50,
              child: CircleAvatar(
                backgroundColor: const Color(0xffE4032F),
                radius: 50,
                child: FadeInLeft(
                    child: const Icon(
                      Icons.mail_outline_outlined,
                      size: 50,
                      color: Colors.white,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BackDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 300,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                child: Column(
                  children: [
                    const Text(
                      "Would you like to Save \nthis as a Draft?",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    MaterialButton(
                      minWidth: 220,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                      elevation: 6,
                      onPressed: () {},
                      child: const Text(
                        "YES",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: const Color(0xffE4032F),
                    ),
                    MaterialButton(
                      minWidth: 220,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                      elevation: 6,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "CANCEL",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.grey,
                    ),
                    MaterialButton(
                      minWidth: 220,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                      elevation: 6,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                      },
                      child: const Text(
                        "NO, BACK TO DASHBOARD",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              child: CircleAvatar(
                backgroundColor: const Color(0xffE4032F),
                radius: 50,
                child: FadeInLeft(
                    child: const Icon(
                      Icons.mail_outline_outlined,
                      size: 50,
                      color: Colors.white,
                    )),
              ),
              top: -50,
            )
          ],
        ),
      ),
    );
  }
}
