import 'package:construct/controllers/buyer_forum_controller.dart';
import 'package:construct/controllers/dashboard_controller.dart';
import 'package:construct/controllers/seller_markerplace_controller.dart';
import 'package:get/get.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardController(), fenix: true);
    Get.lazyPut(() => SellerMarketplaceController(), fenix: true);
    Get.lazyPut(() => BuyerForumController(), fenix: true);
  }
}