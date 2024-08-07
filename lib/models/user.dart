// To parse this JSON data, do
//
//     final UserDataModel = UserDataModelFromJson(jsonString);

import 'dart:convert';

UserDataModel userDataModelFromJson(String str) => UserDataModel.fromJson(json.decode(str));

String userDataModelToJson(UserDataModel data) => json.encode(data.toJson());

class UserDataModel {
  String? status;
  UserModel? data;
  String? message;

  UserDataModel({
    this.status,
    this.data,
    this.message,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
    status: json["status"],
    data: json["data"] == null ? null : UserModel.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
    "message": message,
  };
}

class UserModel {
  String? id;
  String? gcId;
  String? email;
  bool? emailVerified;
  bool? isActive;
  String? businessName;
  String? mcc;
  String? mobileNumber;
  bool? mobileNumberVerified;
  String? businessDescription;
  String? merchantCategory;
  String? imageUrl;
  String? bannerUrl;
  bool? verified;
  bool? available;
  bool? active;
  bool? mfaActive;
  int? rating;
  bool? documentSubmitted;
  Notifications? notifications;
  NotificationsChannels? notification_channels;
  String? address;
  String? city;
  String? postCode;
  String? accountName;
  String? accountNumber;
  String? bankName;
  String? sortCode;
  String? bankBranch;
  String? token;
  String? refreshToken;
  List<StoreTime>? storeTimes;


  UserModel({
    this.id,
    this.gcId,
    this.email,
    this.emailVerified,
    this.businessName,
    this.mcc,
    this.mobileNumber,
    this.mobileNumberVerified,
    this.businessDescription,
    this.merchantCategory,
    this.imageUrl,
    this.bannerUrl,
    this.verified,
    this.available,
    this.active,
    this.mfaActive,
    this.rating,
    this.documentSubmitted,
    this.notifications,
    this.notification_channels,
    this.address,
    this.city,
    this.postCode,
    this.accountName,
    this.accountNumber,
    this.bankName,
    this.sortCode,
    this.bankBranch,
    this.token,
    this.refreshToken,
    this.isActive,
    this.storeTimes,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"] ?? "",
    gcId: json["gc_id"] ?? "",
    isActive: json["is_active"] == 1 ? true : false,
    email: json["email"] ?? "",
    emailVerified: json["email_verified"] == 1 ? true : false,
    businessName: json["business_name"] ?? "",
    mcc: json["mcc"] ?? "",
    mobileNumber: json["mobile_number"] ?? "",
    mobileNumberVerified: json["mobile_number_verified"] == 1 ? true : false,
    businessDescription: json["business_description"] ?? "",
    merchantCategory: json["merchant_category"] ?? "",
    imageUrl: json["image_url"] ?? "",
    bannerUrl: json["banner_url"] ?? "",
    verified: json["verified"] == 1 ? true : false,
    available: json["available"] == 1 ? true : false,
    active: json["active"] == 1 ? true : false,
    mfaActive: json["mfa_active"] == 1 ? true : false,
    rating: json["rating"] ?? "",
    documentSubmitted: json["document_submitted"] == 1 ? true : false,
    notifications: json["notifications"] == null ? null : Notifications.fromJson(json["notifications"]),
    notification_channels: json["notification_channels"] == null ? null : NotificationsChannels.fromJson(json["notification_channels"]),

    address: json["address"] ?? "",
    city: json["city"] ?? "",
    postCode: json["post_code"] ?? "",
    accountName: json["account_name"] ?? "",
    accountNumber: json["account_number"] ?? "",
    bankName: json["bank_name"] ?? "",
    sortCode: json["sort_code"] ?? "",
    bankBranch: json["bank_branch"] ?? "",
    token: json["token"] ?? "",
    storeTimes: json["store_times"] == null ? [] : List<StoreTime>.from(json["store_times"]!.map((x) => StoreTime.fromJson(x))),
    refreshToken: json["refresh_token"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "gc_id": gcId,
    "email": email,
    "is_active": isActive,
    "email_verified": emailVerified,
    "business_name": businessName,
    "mcc": mcc,
    "mobile_number": mobileNumber,
    "mobile_number_verified": mobileNumberVerified,
    "business_description": businessDescription,
    "merchant_category": merchantCategory,
    "image_url": imageUrl,
    "banner_url": bannerUrl,
    "verified": verified,
    "available": available,
    "active": active,
    "mfa_active": mfaActive,
    "rating": rating,
    "document_submitted": documentSubmitted,
    "notifications": notifications?.toJson(),
    "notification_channels": notification_channels?.toJson(),
    "store_times": storeTimes == null ? [] : List<dynamic>.from(storeTimes!.map((x) => x.toJson())),
    "address": address,
    "city": city,
    "post_code": postCode,
    "account_name": accountName,
    "account_number": accountNumber,
    "bank_name": bankName,
    "sort_code": sortCode,
    "bank_branch": bankBranch,
    "token": token,
    "refresh_token": refreshToken,
  };
}

class NotificationsChannels {
  bool? email;
  bool? push;
  bool? sms;

  NotificationsChannels({
    this.email,
    this.push,
    this.sms,
  });

  factory NotificationsChannels.fromJson(Map<String, dynamic> json) => NotificationsChannels(
    email: json["email"] ?? false,
    push: json["push"] ?? false,
    sms: json["sms"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "push": push,
    "sms": sms,
  };
}

class Notifications {
  bool? orders;
  bool? inquiry;
  bool? order_complete;
  bool? security;
  bool? inventory;

  Notifications({
    this.orders,
    this.inquiry,
    this.order_complete,
    this.security,
    this.inventory,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
    orders: json["orders"] ?? false,
    inquiry: json["inquiry"]  ?? false,
    order_complete: json["order_complete"]  ?? false,
    security: json["security"] ?? false,
    inventory: json["inventory"]  ?? false,
  );

  Map<String, dynamic> toJson() => {
    "orders": orders,
    "inquiry": inquiry,
    "order_complete": order_complete,
    "security": security,
    "inventory": inventory,
  };
}

class StoreTime {
  String? day;
  String? openingTime;
  String? closingTime;
  String? weekDays;

  StoreTime({
    this.day,
    this.openingTime,
    this.closingTime,
    this.weekDays,
  });

  factory StoreTime.fromJson(Map<String, dynamic> json) => StoreTime(
    day: json["day"],
    openingTime: json["opening_time"],
    closingTime: json["closing_time"],
  );

  Map<String, dynamic> toJson() => {
    "day": day,
    "opening_time": openingTime,
    "closing_time": closingTime,
  };
}