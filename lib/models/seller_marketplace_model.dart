class SellerMarketplaceModel {
  String? status;
  Data? data;

  SellerMarketplaceModel({this.status, this.data});

  SellerMarketplaceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Posts>? posts;
  int? totalPost;

  Data({this.posts, this.totalPost});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['posts'] != null) {
      posts = <Posts>[];
      json['posts'].forEach((v) {
        posts!.add(new Posts.fromJson(v));
      });
    }
    totalPost = json['totalPost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.posts != null) {
      data['posts'] = this.posts!.map((v) => v.toJson()).toList();
    }
    data['totalPost'] = this.totalPost;
    return data;
  }
}

class Posts {
  Pricing? pricing;
  bool? isDraft;
  bool? isBlackListed;
  List<String>? postImg;
  List<String>? reviews;
  String? dealingMethod;
  List<String>? requests;
  String? sId;
  String? postTitle;
  String? category;
  String? description;
  String? condition;
  String? deliveryType;
  String? subcategory;
  User? user;
  String? companyName;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? iV;
  Availability? availability;
  SMDuration? duration;
  bool? isNonNegotiable;


  Posts(
      {this.pricing,
        this.isDraft,
        this.isBlackListed,
        this.postImg,
        this.reviews,
        this.dealingMethod,
        this.requests,
        this.sId,
        this.postTitle,
        this.category,
        this.description,
        this.condition,
        this.deliveryType,
        this.subcategory,
        this.user,
        this.companyName,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.availability,
        this.duration,
        this.isNonNegotiable});

  Posts.fromJson(Map<String, dynamic> json) {
    pricing =
    json['pricing'] != null ? new Pricing.fromJson(json['pricing']) : null;
    isDraft = json['isDraft'];
    isBlackListed = json['isBlackListed'];
    postImg = json['postImg'].cast<String>();
    reviews = json['reviews'].cast<String>();
    dealingMethod = json['dealing_method'];
    requests = json['requests']!=null? json['requests'].cast<String>():[];
    sId = json['_id'];
    postTitle = json['postTitle'];
    category = json['category'];
    description = json['description'];
    condition = json['condition'];
    deliveryType = json['deliveryType'];
    subcategory = json['subcategory'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    companyName = json['companyName'] ;
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    availability = json['availability'] != null
        ? new Availability.fromJson(json['availability'])
        : null;
    duration = json['duration'] != null
        ? new SMDuration.fromJson(json['duration'])
        : null;
    isNonNegotiable = json['isNonNegotiable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pricing != null) {
      data['pricing'] = this.pricing!.toJson();
    }
    data['isDraft'] = this.isDraft;
    data['isBlackListed'] = this.isBlackListed;
    data['postImg'] = this.postImg;
    data['reviews'] = this.reviews;
    data['dealing_method'] = this.dealingMethod;
    data['requests'] = this.requests;
    data['_id'] = this.sId;
    data['postTitle'] = this.postTitle;
    data['category'] = this.category;
    data['description'] = this.description;
    data['condition'] = this.condition;
    data['deliveryType'] = this.deliveryType;
    data['subcategory'] = this.subcategory;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['companyName'] = this.companyName;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    if (this.availability != null) {
      data['availability'] = this.availability!.toJson();
    }
    if (this.duration != null) {
      data['duration'] = this.duration!.toJson();
    }
    data['isNonNegotiable'] = this.isNonNegotiable;
    return data;
  }
}

class Pricing {
  double? unitPrice;
  int? quantity;
  int? inStock;

  Pricing({this.unitPrice, this.quantity, this.inStock});

  Pricing.fromJson(Map<String, dynamic> json) {
    unitPrice = double.tryParse(json['unitPrice'].toString());
    quantity = json['quantity'];
    inStock = json['inStock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unitPrice'] = this.unitPrice;
    data['quantity'] = this.quantity;
    data['inStock'] = this.inStock;
    return data;
  }
}

class User {
  String? name;
  String? sId;
  String? companyName;
  String? uen;
  double? avgRating;

  User({this.name, this.sId, this.companyName, this.uen, this.avgRating});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    sId = json['_id'];
    companyName = json['companyName'];
    uen = json['uen'];
    if (json['avgRating'] != null)
      avgRating = double.tryParse(json['avgRating'].toString());
    if (json['avgRating'] == null) avgRating = 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['_id'] = this.sId;
    data['companyName'] = this.companyName;
    data['uen'] = this.uen;
    data['avgRating'] = this.avgRating;
    return data;
  }
}

class Availability {
  String? from;
  String? to;
  String? expDate;

  Availability({this.from, this.to, this.expDate});

  Availability.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    to = json['to'];
    expDate = json['expDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from'] = this.from;
    data['to'] = this.to;
    data['expDate'] = this.expDate;
    return data;
  }
}

class SMDuration {
  int? period;
  String? unit;

  SMDuration({this.period, this.unit});

  SMDuration.fromJson(Map<String, dynamic> json) {
    period = json['period'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['period'] = this.period;
    data['unit'] = this.unit;
    return data;
  }
}
