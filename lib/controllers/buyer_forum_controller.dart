import 'dart:convert';

import 'package:get/get.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:flutter/services.dart' as services;



import '../models/buyer_forum_model.dart';

class BuyerForumController extends GetxController{
  RxList<Entries> entries = (<Entries>[]).obs;
  RxInt totalCount = 0.obs;
  Rx<NumberPaginatorController> numberCtrl = NumberPaginatorController().obs;



  void getBuyerForum({required int page}) async{
    final String jsonContent = await services.rootBundle.loadString('assets/json/buyer_forum.json');

    BuyerForumModel _buyerForm =
    BuyerForumModel.fromJson(json.decode(jsonContent));

    entries(_buyerForm.data!.entries!);
    totalCount(_buyerForm.data!.count!);
  }
}