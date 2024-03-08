import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_toolkit/breakpoints.dart';

import '../../controllers/seller_markerplace_controller.dart';


class SaleLeaseButtons extends StatefulWidget {
  const SaleLeaseButtons({Key? key}) : super(key: key);

  @override
  State<SaleLeaseButtons> createState() => _SaleLeaseButtonsState();
}

class _SaleLeaseButtonsState extends State<SaleLeaseButtons> {
  // List<bool> isSelected = [true, false, false];
  final sellerMarketplaceCtrl = Get.find<SellerMarketplaceController>();

  @override
  Widget build(BuildContext context) => Obx(() => ToggleButtons(
    fillColor: const Color(0xffE4032F),
    color: Colors.red,
    selectedColor: Colors.white,
    isSelected: sellerMarketplaceCtrl.isSelectedToggle.value,
    borderRadius: const BorderRadius.all(Radius.circular(15)),
    splashColor: Colors.red.withOpacity(0.5),
    children:   <Widget>[
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Text("All Post", style: TextStyle(fontSize: Breakpoints(xs: 11.0, sm: 14.0, md: 17.0, lg: 20.0)
            .choose(Get.width),),),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Text("Sale", style: TextStyle(fontSize: Breakpoints(xs: 11.0, sm: 14.0, md: 17.0, lg: 20.0)
            .choose(Get.width),),),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Text("Lease", style: TextStyle(fontSize: Breakpoints(xs: 11.0, sm: 14.0, md: 17.0, lg: 20.0)
            .choose(Get.width),),),
      ),
    ],
    onPressed: (int newIndex) {
      setState(() {
        for (int index = 0;
        index < sellerMarketplaceCtrl.isSelectedToggle.value.length;
        index++) {
          if (index == newIndex) {
            sellerMarketplaceCtrl.isSelectedToggle.value[index] = true;
          } else {
            sellerMarketplaceCtrl.isSelectedToggle.value[index] = false;
          }
        }
      });

      switch (newIndex) {
        case 0:
          sellerMarketplaceCtrl.getSellerMarketplace(
              page: 1, pageType: "all_post");
          sellerMarketplaceCtrl.numberCtrl.value.currentPage = 0;
          return;
        case 1:
          sellerMarketplaceCtrl.getSellerMarketplace(
              page: 1, pageType: "sale");
          sellerMarketplaceCtrl.numberCtrl.value.currentPage = 0;
          return;
        case 2:
          sellerMarketplaceCtrl.getSellerMarketplace(
              page: 1, pageType: "lease");
          sellerMarketplaceCtrl.numberCtrl.value.currentPage = 0;
          return;
      }
    },
  ));
}