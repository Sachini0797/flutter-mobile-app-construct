import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/seller_markerplace_controller.dart';


class SearchPost extends StatelessWidget {
  final sellerMarketplaceCtrl = Get.find<SellerMarketplaceController>();

  SearchPost({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: TextFormField(
        onChanged: (e) {
          sellerMarketplaceCtrl.search(e);
          sellerMarketplaceCtrl.numberCtrl.value.currentPage = 0;
          sellerMarketplaceCtrl.getSellerMarketplace(
              page: 0, pageType: 'all_post');
          sellerMarketplaceCtrl.isSelectedToggle([true, false, false]);
        },
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.grey,
            size: 25,
          ),

          // helperText: "Search here now",
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelText: "Search Post",
          labelStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          isDense: true,
        ),
      ),
    );
  }
}
