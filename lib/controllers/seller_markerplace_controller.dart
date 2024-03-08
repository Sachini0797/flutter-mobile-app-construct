import 'dart:convert';

import 'package:get/get.dart';
import 'package:number_paginator/number_paginator.dart';

import '../models/seller_marketplace_model.dart';
import 'package:flutter/services.dart' as services;

class SellerMarketplaceController extends GetxController {
  RxString page_type = "all_post".obs;
  RxString search = ''.obs;
  RxString all_search = ''.obs;
  RxList<bool> isSelectedToggle = [true, false, false].obs;
  RxList<Posts> posts = (<Posts>[]).obs;
  RxInt totalCount = 0.obs;
  Rx<DateTime> initStartDate = DateTime.now().obs;
  Rx<DateTime> initEndDate = DateTime.now().obs;
  Rx<NumberPaginatorController> numberCtrl = NumberPaginatorController().obs;


  void getSellerMarketplace({required int page, required String pageType}) async{
    final String jsonContent = await services.rootBundle.loadString('assets/json/sellerMP.json');

    SellerMarketplaceModel _sellerMarketplace =
    SellerMarketplaceModel.fromJson(json.decode(jsonContent));
    // sellerMarketplace!(_sellerMarketplace);

    posts(_sellerMarketplace.data!.posts!);
    totalCount(_sellerMarketplace.data!.totalPost!);
  }
  void setNumberCtrl(NumberPaginatorController controller) {
    numberCtrl(controller);
  }
}