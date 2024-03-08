import 'package:get/get.dart';

class DashboardController extends GetxController {
  RxString currentPageName = "Dashbaord".obs;
  RxInt pendingTransactions = 0.obs;
  RxInt inbox = 0.obs;
  RxInt reviews = 0.obs;
  RxInt performance = 0.obs;
  RxInt unsuccessfulOrders = 0.obs;
  RxInt completedOrders = 0.obs;
}