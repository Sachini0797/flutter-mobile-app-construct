import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:construct/consts/colors.dart';
import 'package:construct/utils/to_double_ext.dart';
import 'package:construct/views/home_screen/home_screen.dart';
import 'package:construct/views/seller_marketplace/model/items.dart';

import 'package:flutter/material.dart';

 import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/seller_markerplace_controller.dart';
import '../../custom_widget/form_theme_helper.dart';


class ConfirmPriceButton extends StatelessWidget {
  ConfirmPriceButton({Key? key, required this.product}) : super(key: key);
  final Product product;
  var dragScrlCtrl1, dragScrlCtrl2, dragScrlCtrl3, dragScrlCtrl4 = DraggableScrollableController();
   final sellerMarketplaceCtrl = Get.find<SellerMarketplaceController>();

  RxBool clickedConfirm = false.obs;
  var orderid;
  var sellerEmail;
  var viewOid;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         getLeaseConfirmPrice(context),
        // (product.dealingMethod == "both" || product.dealingMethod == "direct_deal"?
        // (Obx(() =>
            MaterialButton(
          minWidth: 220,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          elevation: 6,
          onPressed: () {
            getDirectDealBottomSheet(_DirectDealBottomSheet);

          },
          child: const Text(
            "DIRECT DEAL WITH SELLER",
            style: TextStyle(color: Colors.white),
          ),
          color:
          isValidDateRange.isTrue
              ? const Color(0xff0EA5E9)
              : const Color(0xffa4a4a4),
        ),

             MaterialButton(
          minWidth: 220,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          elevation: 6,
          onPressed: () {
            getShowConfirmPriceBottomSheet(_buildBottomSheet);

          },
          child: const Text(
            "CONFIRM PRICE & SUBMIT",
            style: TextStyle(color: Colors.white),
          ),
          color:  isValidDateRange.isTrue

              ? const Color(0xffE4032F)
              : const Color(0xffa4a4a4),
        )
        // )) : Container()),

      ],
    );
  }

  TextEditingController dateTimeRangeCtrl = TextEditingController();
  TextEditingController messageCtrl = TextEditingController();
  RxBool isValidDateRange = true.obs;
  RxBool isValidOfferedPrice = true.obs;
  RxBool isValidQuantity = false.obs;
  RxInt quantityCtrl = 0.obs;
  // RxDouble prefferedPriceCtrl = 0.0.obs;
  TextEditingController totalPriceCtrl = TextEditingController();
  getLeaseConfirmPrice(context) {

    final df = DateFormat('MMM dd, yyyy ');
    if (product != null) {
      if (product.type == 'lease') {
        String from = product.from!;
        String to = product.to!;
        var _period = product.period ?? 0;
        var unit = product.unit ?? "";


        period = unit == 'Days' ? _period : (_period * 7);
        if (DateTime.parse(from).isAfter(DateTime.now())) {
          sellerMarketplaceCtrl.initStartDate(DateTime.parse(from));
        } else {
          sellerMarketplaceCtrl.initStartDate(DateTime.now());
        }
        sellerMarketplaceCtrl.initEndDate(sellerMarketplaceCtrl.initStartDate.value.add(Duration(days: period-1)));
        isValidDateRange(true);


        final df = DateFormat('MMM dd, yyyy ');
        if (product.type == 'lease') {
          String _from = product.from!;
          String _to = product.to!;
          dateTimeRangeCtrl.text = '${df.format(sellerMarketplaceCtrl.initStartDate.value)} - ${df.format(sellerMarketplaceCtrl.initEndDate.value)}';
        }
      }
    }

    return Column(
      children: [
        getGap(),
        Column(
          children: <Widget>[
            (product.type == 'lease'
                ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: TextFormField(
                      controller: dateTimeRangeCtrl,
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.number,
                      decoration: FormThemeHelper().formTextInputStyle('To - From', 'Select Date Range'),
                      onChanged: (String value) {},
                      readOnly: true,
                      onTap: () {
                        String from = product.from!;
                        String to = product.to!;
                        var _period = product.period!;
                        var unit = product.unit!;
                        var startDate = DateTime.parse(from).isAfter(DateTime.now()) ? DateTime.parse(from) : DateTime.now();
                        period = (unit == 'Days' ? _period : (_period * 7));
                        showDateRangePicker(
                            context: context,
                            firstDate: startDate,
                            lastDate: DateTime.parse(to),
                            initialDateRange: DateTimeRange(start: sellerMarketplaceCtrl.initStartDate.value, end: sellerMarketplaceCtrl.initEndDate.value))
                            .then((value) {
                          if (value!.end.difference(value.start).inDays < ( period-1)) {
                            isValidDateRange(false);
                            return;
                          }
                          isValidDateRange(true);
                          sellerMarketplaceCtrl.initStartDate(value.start);
                          sellerMarketplaceCtrl.initEndDate(value.end);
                          dateTimeRangeCtrl.text = '${df.format(value.start)} - ${df.format(value.end)}';
                          calculateOfferedPrice();
                        });
                      },

                    ))
              ],
            )
                : Container()),
            (product.type == 'lease' ? Obx(() => isValidDateRange.isFalse ? getErrorMsg('Duration is invalid, range must be higher than post duration') : Container()) : Container()),
            getGap(),
          ],
        ),
        Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.number,
                      decoration: FormThemeHelper().formTextInputStyle('Quantity*', 'Edit quantity'),
                      onChanged: (String value) {
                        if(value.isNotEmpty && value != 0 && quantityCtrl.value <= (product.inStock!)){
                          isValidQuantity(true);
                        }
                        quantityCtrl(value.isNum ? int.parse(value) : 0);
                        calculateOfferedPrice();
                      },
                    )),
              ],
            ),
            Obx(() => quantityCtrl.value > (product.inStock!) ? getErrorMsg('Quantity is invalid') : Container()),
          ],
        ),
        getGap(),
        getGap(),
        Row(
          children: [
            Expanded(
                child: TextFormField(
                  readOnly: true,
                  controller: totalPriceCtrl,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.number,
                  decoration: FormThemeHelper().formTextInputStyle('Total Price ', 'total of the order', 'SGD', const Color(0x49a4a4a4)),
                )),
          ],
        )
        ,
      ],
    );
  }

  calculateOfferedPrice() {
    var qty = quantityCtrl.value;
    var unitPrice = product.unitPrice;
    if (product.type == 'lease') {
      DateTime start = sellerMarketplaceCtrl.initStartDate.value;
      DateTime end = sellerMarketplaceCtrl.initEndDate.value;
      var period = end.difference(start).inDays+1;
      totalPriceCtrl.text = ((period * qty) * unitPrice).toString().toSGD();
    } else {
      totalPriceCtrl.text = (qty * unitPrice).toString().toSGD();
    }
  }

  getShowConfirmPriceBottomSheet(sheet) {
    showFlexibleBottomSheet(
        minHeight: 0,
        initHeight: 0.50,
        maxHeight: .50,
        bottomSheetColor: Colors.transparent,
        barrierColor: const Color.fromARGB(120, 0, 0, 0),
        context: Get.context!,
        draggableScrollableController: dragScrlCtrl1,
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
  getShowConfirmOrderBottomSheet(sheet) {
    showFlexibleBottomSheet(
        minHeight: 0,
        initHeight: 0.30,
        maxHeight: .30,
        bottomSheetColor: Colors.transparent,
        barrierColor: const Color.fromARGB(120, 0, 0, 0),
        context: Get.context!,
        draggableScrollableController: dragScrlCtrl2,
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

  getGap() {
    return const SizedBox(
      height: 12,
      width: 12,
    );
  }

  getOrderInfoRow(String title, String value) {
    return Table(
      columnWidths: Map.from({0: const FractionColumnWidth(.35), 1: const FractionColumnWidth(.65)}),
      border: TableBorder.all(),
      children: [
        TableRow(children: [
          Container(
            color: const Color.fromARGB(68, 145, 145, 145),
            padding: const EdgeInsets.all(8),
            child: Text('$title'),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Text('$value'),
          ),
        ])
      ],
    );
  }

  getErrorMsg(String msg) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Text(
        msg,
        style: const TextStyle(color: Colors.red),
        textAlign: TextAlign.center,
        softWrap: true,
      ),
    );
  }

  int period = 0;

  Widget _buildBottomSheet(
      BuildContext context,
      ScrollController scrollController1,
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
            controller: scrollController1,
            shrinkWrap: true,
            children: [
              const Icon(
                Icons.email_outlined,
                size: 50,
                color: Color(0xffE4032F),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(product.sellerName!),
                  const Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Text("N/A")
                    ],
                  )
                ],
              ),
              getGap(),
              Center(
                child: Column(
                  children: [
                    Text(
                      product.companyName!,
                      style: const TextStyle(color: Color(0xffE4032F)),
                    ),
                    Text(
                      "#" + product.productID!,
                      style: const TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ),
              getGap(),
              getOrderInfoRow('Quantity:', (product.type == 'lease' ? quantityCtrl.toString() : quantityCtrl.toString())),
              getOrderInfoRow('Total Price', "SGD " + '${totalPriceCtrl.text}'),
              getOrderInfoRow('Original Posted Price:', 'SGD ' + '${product.unitPrice.toString().toSGD()}'),
              getGap(),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (product.type == "lease"
                      ? Expanded(
                      child: Obx(() =>  MaterialButton(
                        minWidth: 200,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)),
                        elevation: 6,
                        onPressed: () {
                          getShowConfirmOrderBottomSheet(_ConfirmedBuildBottomSheet);
                          clickedConfirm(true);
                          const GetSnackBar(
                            title: '',
                            message: 'You already have an ongoing order, Please proceed to make payment before ordering again',
                            backgroundColor: appColor,
                            duration:  Duration(seconds: 7),
                          ).show();
                          Get.back();

                        },
                        textColor: Colors.white,
                        color:isValidDateRange.isFalse && quantityCtrl.value.isNaN && clickedConfirm.isTrue ? Colors.grey: const Color(0xffE4032F),
                        // color: clickedConfirm.isTrue ? Colors.grey : Color(0xffE4032F),
                        child: const Text('CONFIRM'),
                      )))
                      : Expanded(
                      child: Obx(() => MaterialButton(
                        minWidth: 200,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)),
                        elevation: 6,
                        onPressed: () {
                          if(clickedConfirm.isTrue){
                            return ;
                          }
                          getShowConfirmOrderBottomSheet(_ConfirmedBuildBottomSheet);
                          clickedConfirm(true) ;
                          const GetSnackBar(
                            title: '',
                            message: 'You already have an ongoing order, Please proceed to make payment before ordering again',
                            backgroundColor: appColor,
                            duration: Duration(seconds: 7),
                          ).show();
                         Get.back();

                        },
                        textColor: Colors.white,
                        color: clickedConfirm.isTrue ? Colors.grey : const Color(0xffE4032F),
                        child: const Text('CONFIRM'),
                      )))),
                  getGap(),
                  Expanded(
                      child: MaterialButton(
                        minWidth: 200,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)),
                        elevation: 6,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: Colors.black,
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


  openPaymentGateway(){

  }
  Widget _ConfirmedBuildBottomSheet(
      BuildContext context,
      ScrollController scrollController2,
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
            controller: scrollController2,
            shrinkWrap: true,
            children: [
              const Icon(
                Icons.email_outlined,
                size: 50,
                color: Color(0xffE4032F),
              ),
              Center(
                child: Column(
                  children: [
                    Text("#"+viewOid, style: const TextStyle(color: Colors.grey),),
                    getGap(),
                    const Text("Thank You!", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                    const Text("Your order has been confirmed!"),



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
                          openPaymentGateway();
                          // Navigator.pop(context);
                          Get.back();
                        },
                        textColor: Colors.white,
                        color: const Color(0xffE4032F),
                        child: const Text('PAY FOR ORDER'),
                      )),
                  getGap(),
                  Expanded(
                      child: MaterialButton(
                        minWidth: 200,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        elevation: 6,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: Colors.black,
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

  getDirectDealBottomSheet(sheet) {
    showFlexibleBottomSheet(
        minHeight: 0,
        initHeight: 0.50,
        maxHeight: .50,
        bottomSheetColor: Colors.transparent,
        barrierColor: const Color.fromARGB(120, 0, 0, 0),
        context: Get.context!,
        draggableScrollableController: dragScrlCtrl3,
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
  Widget _DirectDealBottomSheet(
      BuildContext context,
      ScrollController scrollController2,
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
            controller: scrollController2,
            shrinkWrap: true,
            children: [
              const Icon(
                Icons.email_outlined,
                size: 50,
                color: Color(0xffE4032F),
              ),
              Center(
                child: Column(
                  children: [
                    getGap(),
                    Row(
                      children: [
                        Text(product.sellerName.toString(), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                      ],
                    ),
                    Text(product.companyName.toString(),style: const TextStyle(color: Colors.red),),
                    Text("#"+product.productID.toString(), style: const TextStyle(color: Colors.grey),),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Quantity:"),
                        Text(quantityCtrl.toString())
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Original listed Unit Price:"),
                        Text("SGD " + product.unitPrice.toStringAsFixed(2))
                      ],
                    ),
                    getGap(),

                    Text("You have selected to deal directly (payment and acceptance) with the seller for " + quantityCtrl.toString() + " quantity of this item."
                        " With this option,all platform facilitation and liabilities will end.", style: const TextStyle(color: Colors.red), textAlign: TextAlign.center,),
                    const Text(" Please select confirm to proceed.", style: TextStyle(color: Colors.red),)

                  ],
                ),
              ),

              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (product.type == "lease" ? Expanded(
                      child: MaterialButton(
                        minWidth: 200,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        elevation: 6,
                        onPressed: () {
                          {
                            Container(
                                child: getConfirmedDirectDealBottomSheet(_ConfirmedDirectDealBottomSheet)
                            );


                          }
                          Get.back();
                        },
                        textColor: Colors.white,
                        color: const Color(0xffE4032F),
                        child: const Text('Confirm'),
                      )) : Expanded(
                      child: MaterialButton(
                        minWidth: 200,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        elevation: 6,
                        onPressed: () {
                          {
                            Container(
                                child: getConfirmedDirectDealBottomSheet(_ConfirmedDirectDealBottomSheet)
                            );
                          }
                          Get.back();
                        },
                        textColor: Colors.white,
                        color: const Color(0xffE4032F),
                        child: const Text('Confirm'),
                      ))),
                  getGap(),
                  Expanded(
                      child: MaterialButton(
                        minWidth: 200,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        elevation: 6,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: Colors.black,
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

  getConfirmedDirectDealBottomSheet(sheet) {
    showFlexibleBottomSheet(
        minHeight: 0,
        initHeight: 0.50,
        maxHeight: .50,
        bottomSheetColor: Colors.transparent,
        barrierColor: const Color.fromARGB(120, 0, 0, 0),
        context: Get.context!,
        draggableScrollableController: dragScrlCtrl4,
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
  Widget _ConfirmedDirectDealBottomSheet(
      BuildContext context,
      ScrollController scrollController2,
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
            controller: scrollController2,
            shrinkWrap: true,
            children: [
              const Icon(
                Icons.email_outlined,
                size: 50,
                color: Color(0xffE4032F),
              ),
              Center(
                child: Column(
                  children: [
                    Text("#"+viewOid, style: const TextStyle(color: Colors.grey),),
                    getGap(),
                    const Text("Thank You!", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                    const Text("Your order has been confirmed!"),

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
                          Navigator.pushAndRemoveUntil<dynamic>(
                            context,
                            MaterialPageRoute<dynamic>(
                              builder: (BuildContext context) => const HomeScreen(),
                            ),
                                (route) => false,//if you want to disable back feature set to false
                          );

                        },
                        color: Colors.black,
                        textColor: Colors.white,
                        child: const Text('BACK TO DASHBOARD'),
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
