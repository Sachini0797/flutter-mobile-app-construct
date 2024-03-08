class BuyerForumModel {
  String? status;
  Data? data;

  BuyerForumModel({this.status, this.data});

  BuyerForumModel.fromJson(Map<String, dynamic> json) {
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
  List<Entries>? entries;
  int? count;

  Data({this.entries, this.count});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['entries'] != null) {
      entries = <Entries>[];
      json['entries'].forEach((v) {
        entries!.add(new Entries.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.entries != null) {
      data['entries'] = this.entries!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class Entries {
  List<String>? types;
  List<String>? images;
  String? sId;
  User? user;
  String? reqFrom;
  String? title;
  String? description;
  String? category;
  String? requestId;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? anonymousUser;

  Entries(
      {this.types,
        this.images,
        this.sId,
        this.user,
        this.reqFrom,
        this.title,
        this.description,
        this.category,
        this.requestId,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.anonymousUser});

  Entries.fromJson(Map<String, dynamic> json) {
    types = json['types'].cast<String>();
    images = json['images'].cast<String>();
    sId = json['_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    reqFrom = json['reqFrom'];
    title = json['title'];
    description = json['description'];
    category = json['category'];
    requestId = json['requestId'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    anonymousUser = json['anonymousUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['types'] = this.types;
    data['images'] = this.images;
    data['_id'] = this.sId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['reqFrom'] = this.reqFrom;
    data['title'] = this.title;
    data['description'] = this.description;
    data['category'] = this.category;
    data['requestId'] = this.requestId;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['anonymousUser'] = this.anonymousUser;
    return data;
  }
}

class User {
  Tazapay? tazapay;
  String? name;
  String? designation;
  String? secondaryEmail;
  List<String>? professionalAccreditations;
  List<String>? interests;
  bool? isEmailVerified;
  bool? isIndividual;
  bool? isBlackListed;
  bool? showInSearch;
  List<String>? firebaseToken;
  String? sId;
  String? email;
  int? otp;
  String? status;
  String? userRole;
  String? createdAt;
  String? updatedAt;
  String? passwordChangedAt;
  int? iV;
  String? companyName;
  String? firstname;
  String? lastname;
  String? uen;
  String? company;
  String? phone;
  String? passwordResetToken;
  String? passwordResetTokenExpires;
  String? profile;
  dynamic? avgRating;

  User(
      {this.tazapay,
        this.name,
        this.designation,
        this.secondaryEmail,
        this.professionalAccreditations,
        this.interests,
        this.isEmailVerified,
        this.isIndividual,
        this.isBlackListed,
        this.showInSearch,
        this.firebaseToken,
        this.sId,
        this.email,
        this.otp,
        this.status,
        this.userRole,
        this.createdAt,
        this.updatedAt,
        this.passwordChangedAt,
        this.iV,
        this.companyName,
        this.firstname,
        this.lastname,
        this.uen,
        this.company,
        this.phone,
        this.passwordResetToken,
        this.passwordResetTokenExpires,
        this.profile,
        this.avgRating});

  User.fromJson(Map<String, dynamic> json) {
    tazapay =
    json['tazapay'] != null ? new Tazapay.fromJson(json['tazapay']) : null;
    name = json['name'];
    designation = json['designation'];
    secondaryEmail = json['secondaryEmail'];
    professionalAccreditations =
        json['professionalAccreditations'].cast<String>();
    interests = json['interests'].cast<String>();
    isEmailVerified = json['isEmailVerified'];
    isIndividual = json['isIndividual'];
    isBlackListed = json['isBlackListed'];
    showInSearch = json['showInSearch'];
    firebaseToken = json['firebaseToken'].cast<String>();
    sId = json['_id'];
    email = json['email'];
    otp = json['otp'];
    status = json['status'];
    userRole = json['userRole'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    passwordChangedAt = json['passwordChangedAt'];
    iV = json['__v'];
    companyName = json['companyName'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    uen = json['uen'];
    company = json['company'];
    phone = json['phone'];
    passwordResetToken = json['passwordResetToken'];
    passwordResetTokenExpires = json['passwordResetTokenExpires'];
    profile = json['profile'];
    avgRating = json['avgRating'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tazapay != null) {
      data['tazapay'] = this.tazapay!.toJson();
    }
    data['name'] = this.name;
    data['designation'] = this.designation;
    data['secondaryEmail'] = this.secondaryEmail;
    data['professionalAccreditations'] = this.professionalAccreditations;
    data['interests'] = this.interests;
    data['isEmailVerified'] = this.isEmailVerified;
    data['isIndividual'] = this.isIndividual;
    data['isBlackListed'] = this.isBlackListed;
    data['showInSearch'] = this.showInSearch;
    data['firebaseToken'] = this.firebaseToken;
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['otp'] = this.otp;
    data['status'] = this.status;
    data['userRole'] = this.userRole;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['passwordChangedAt'] = this.passwordChangedAt;
    data['__v'] = this.iV;
    data['companyName'] = this.companyName;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['uen'] = this.uen;
    data['company'] = this.company;
    data['phone'] = this.phone;
    data['passwordResetToken'] = this.passwordResetToken;
    data['passwordResetTokenExpires'] = this.passwordResetTokenExpires;
    data['profile'] = this.profile;
    data['avgRating'] = this.avgRating;
    return data;
  }
}

class Tazapay {
  bool? isSeller;
  String? accountId;
  bool? hasOrders;
  bool? isBankVerified;
  bool? isKybVerified;
  bool? isVerified;

  Tazapay(
      {this.isSeller,
        this.accountId,
        this.hasOrders,
        this.isBankVerified,
        this.isKybVerified,
        this.isVerified});

  Tazapay.fromJson(Map<String, dynamic> json) {
    isSeller = json['isSeller'];
    accountId = json['accountId'];
    hasOrders = json['hasOrders'];
    isBankVerified = json['isBankVerified'];
    isKybVerified = json['isKybVerified'];
    isVerified = json['isVerified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isSeller'] = this.isSeller;
    data['accountId'] = this.accountId;
    data['hasOrders'] = this.hasOrders;
    data['isBankVerified'] = this.isBankVerified;
    data['isKybVerified'] = this.isKybVerified;
    data['isVerified'] = this.isVerified;
    return data;
  }
}
