// enum dealingMethod {cs_platform,direct_deal,both}
// enum Category {lease, sale, proServices}

class ProductDetails {
  var subcategory;
  late String postTitle;
  late String category;
  late String description;
  late bool iscsPayment;
  late bool isDirectDeal;
  late String condition;
  late DateTime fromDate;
  late DateTime toDate;
  late String period;
  late String weekOrDays;
  late double unitPrice;
  late int quantity;
  late String deliveryType;
  late String dealingMethod;
  late double ? platformFee;
  late List <String>  image;
  late List<String> requestID;
  late bool isNonNegotiable;
  late bool checkNA;
}
