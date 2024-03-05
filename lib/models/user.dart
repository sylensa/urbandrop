// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';
import 'dart:math';

UserDataModel userModelFromJson(String? str) => UserDataModel.fromJson(json.decode(str!));

String? userModelToJson(UserDataModel data) => json.encode(data.toJson());

class UserDataModel {
  UserDataModel({
    this.status,
    this.data,
    this.message,
  });

  bool? status;
  UserModel? data;
  String? message;

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
    status: json["status"],
    data: json["data"] == null ? null : UserModel.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? null : data!.toJson(),
    "message": message,
  };
}

class UserModel {
  UserModel({
    this.id,
    this.fullName,
    this.email,
    this.mobileNumber,
    this.gender,
    this.userType,
    this.tagName,
    this.strapLine,
    this.city,
    this.country,
    this.stageName,
    this.photoUrl,
    this.bio,
    this.isActive,
    this.gcid,
    this.token,
    this.refreshToken,
    this.emailVerified,
    this.biometricEnable,
    this.newSocialLogin,
    this.passcode,
    this.walletBalance,
    this.mobileNumberVerified,
    this.currency,
    this.firstName,
    this.lastName,
    this.backdropUrl,
    this.isPrivate,
    this.profileCompletion,
    this.followers,
    this.following,
    this.followsYou,
    this.youFollow,
    this.missingProfileItems,
    this.collectedCardsCount,
    this.createdCardsCount,
    this.tiktok,
    this.twitter,
    this.facebook,
    this.instagram,
    this.website,
    this.state,
    this.trash,
    this.archived,
    this.date_of_birth,
    this.post_code,
    this.address_line_1,
    this.address_line_2,
    this.billing_info_set,
    this.ownershipPercentage,
    this.spendBalance,
    this.verified,
    this.mcc,
    this.document_uploaded,
    this.kyc_completed,
    this.access,
    this.weavr,
    this.shareholders,
    this.songs,
    this.selected,
    this.topHolders,
    this.notificationPreferences,
    this.block,
  });

  String? id;
  Weavr? weavr;
  String? fullName;
  String? email;
  String? mobileNumber;
  String? gender;
  String? userType;
  String? tagName;
  String? strapLine;
  String? city;
  String? country;
  String? stageName;
  String? songs;
  bool? verified;
  bool? block;
  bool? selected;
  String? photoUrl;
  String? bio;
  bool? isActive;
  bool? isPrivate;
  dynamic date_of_birth;
  dynamic shareholders;
  String? gcid;
  String? token;
  String? refreshToken;
  bool? emailVerified;
  bool? biometricEnable;
  dynamic newSocialLogin;
  String? passcode;
  String? currency;
  String? firstName;
  String? lastName;
  String? state;
  String? post_code;
  String? address_line_1;
  String? address_line_2;
  String? mcc;
  bool? billing_info_set;
  bool? access;
  bool? mobileNumberVerified;
  dynamic walletBalance;
  dynamic spendBalance;
  dynamic profileCompletion;
  List<String>? missingProfileItems;
  String? backdropUrl;
  String? twitter;
  String? facebook;
  String? instagram;
  String? website;
  String? tiktok;
  bool? youFollow;
  bool? followsYou;
  bool? document_uploaded;
  bool? kyc_completed;
  int? followers;
  int? following;
  dynamic collectedCardsCount;
  dynamic createdCardsCount;
  bool? archived;
  bool? trash;
  dynamic ownershipPercentage;
  List<TopHolder>? topHolders;
  List<NotificationPreference>? notificationPreferences;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    fullName: json["full_name"] ?? "",
    state: json["state"] ?? "",
    mcc: json["mcc"] ?? "+44",
    archived: json["archived"] ?? false,
    block: json["block"] ?? false,
    selected: json["selected"] ?? false,
    access: json["access"] ?? false,
    trash: json["trash"] ?? false,
    shareholders: json["shareholders"] ?? "",
    kyc_completed: json["kyc_completed"] ?? false,
    verified: json["verified"] ?? false,
    document_uploaded: json["document_uploaded"] ?? false,
    address_line_1: json["address_line_1"] ?? "",
    address_line_2: json["address_line_2"] ?? "",
    post_code: json["post_code"] ?? "",
    songs: json["songs"] ?? "0",
    billing_info_set: json["billing_info_set"] ?? false,
    ownershipPercentage: json["ownership_percentage"] ?? "",
    missingProfileItems: json["missing_profile_items"] == null ? [] : List<String>.from(json["missing_profile_items"]!.map((x) => x)),
    youFollow: json["you_follow"] ?? false,
    createdCardsCount: json["created_cards_count"] ?? 0,
    collectedCardsCount: json["collected_cards_count"] ?? 0,
    spendBalance: json["spend_balance"] == null || json["spend_balance"] .toString().isEmpty ? "0.00" : json["spend_balance"].toString(),
    twitter: json["twitter"] ?? "",
    facebook: json["facebook"] ?? "",
    instagram: json["instagram"] ?? "",
    tiktok: json["tiktok"] ?? "",
    website: json["website"] ?? "",
    followsYou: json["follows_you"] ?? false,
    followers: json["followers"] ?? 0,
    following: json["following"] ?? 0,
    isPrivate: json["is_private"] ?? false,
    profileCompletion: json["profile_completion"] ?? "0",
    firstName: json["first_name"] ?? "",
    lastName: json["last_name"] ?? "",
    email: json["email"] ?? "",
    currency: json["currency"] ?? "£",
    mobileNumber: json["mobile_number"] ?? "",
    gender: json["gender"] ?? "",
    userType: json["user_type"] ?? "",
    tagName: json["tag_name"] ?? "",
    strapLine: json["strap_line"] ?? "",
    city: json["city"] ?? "",
    backdropUrl: json["backdrop_url"] ?? "",
    country: json["country"] ?? "",
    stageName: json["stage_name"] ?? "",
    photoUrl: json["photo_url"] ?? "",
    bio: json["bio"] ?? "",
    isActive: json["is_active"] ?? false,
    date_of_birth: json["date_of_birth"] ?? "",
    gcid: json["gcid"] ?? "",
    token: json["token"] ?? "",
    notificationPreferences: json["notification_preferences"] == null ? [] : List<NotificationPreference>.from(json["notification_preferences"]!.map((x) => NotificationPreference.fromJson(x))),
    refreshToken: json["refresh_token"] ?? "",
    emailVerified: json["email_verified"] ?? false,
    biometricEnable: json["biometric_enabled"] ?? false,
    newSocialLogin: json["new_social_login"] ?? false,
    mobileNumberVerified: json["mobile_number_verified"] ?? false,
    passcode: json["pass_code"],
    topHolders: json["topHolders"] == null ? [] : List<TopHolder>.from(json["topHolders"]!.map((x) => TopHolder.fromJson(x))),
    weavr: json["weavr"] == null ? null : Weavr.fromJson(json["weavr"]),
    walletBalance: json["wallet_balance"] == null ? "0.00" :json["wallet_balance"].toString().isNotEmpty ? json["wallet_balance"] : "0.00",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "full_name": fullName,
    "email": email,
    "weavr": weavr?.toJson(),
    "ownership_percentage": ownershipPercentage,
    "profile_completion": profileCompletion ?? "",
    "is_private": isPrivate ?? false,
    "kyc_completed": kyc_completed ?? false,
    "access": access ?? access,
    "mobile_number": mobileNumber,
    "gender": gender,
    "notification_preferences": notificationPreferences == null ? [] : List<dynamic>.from(notificationPreferences!.map((x) => x.toJson())),

    "user_type": userType,
    "tag_name": tagName,
    "strap_line": strapLine,
    "city": city,
    "backdrop_url": backdropUrl ?? "",
    "website": website ?? "",
    "archived": archived ?? false,
    "trash": trash ?? false,
    "block": block ?? false,
    "country": country,
    "stage_name": stageName,
    "photo_url": photoUrl,
    "mobile_number_verified": mobileNumberVerified ?? false,
    "bio": bio,

    "is_active": isActive,
    "date_of_birth": date_of_birth == null ? null : date_of_birth!,
    "gcid": gcid,
    "token": token,
    "wallet_balance": walletBalance ?? "0.00",
    "refresh_token": refreshToken,
    "email_verified": emailVerified ?? false,
    "biometric_enabled": biometricEnable,
    "pass_code": passcode,
    "new_social_login": newSocialLogin,
    "top_holders": topHolders == null ? [] : List<dynamic>.from(topHolders!.map((x) => x.toJson())),

  };
}

class TopHolder {
  UserModel? userProfile;

  TopHolder({
    this.userProfile,
  });

  factory TopHolder.fromJson(Map<String, dynamic> json) => TopHolder(
    userProfile: json["user"] == null ? null : UserModel.fromJson(json["user"]),

  );

  Map<String, dynamic> toJson() => {
    "user": userProfile,
  };
}

class Weavr {
  String? id;
  String? userId;
  String? token;
  bool? email_verified;
  bool? mobile_verified;
  bool? kyc_completed;
  String? kyc_status;
  String? verificationFlow;
  String? accessToken;
  String? identityType;
  String? externalUserId;
  String? kycProviderKey;


  Weavr({
    this.id,
    this.userId,
    this.token,
    this.email_verified,
    this.mobile_verified,
    this.kyc_completed,
    this.verificationFlow,
    this.accessToken,
    this.identityType,
    this.kyc_status,
    this.externalUserId,
    this.kycProviderKey,
  });

  factory Weavr.fromJson(Map<String, dynamic> json) => Weavr(
    id: json["id"],
    userId: json["user_id"],
    token: json["token"],
    email_verified: json["email_verified"],
    kyc_status: json["kyc_status"] ?? "",
    mobile_verified: json["mobile_verified"],
    kyc_completed: json["kyc_completed"],
    verificationFlow: json["verificationFlow"],
    accessToken: json["accessToken"],
    identityType: json["identityType"],
    externalUserId: json["externalUserId"],
    kycProviderKey: json["kycProviderKey"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "token": token,
    "email_verified": email_verified,
    "mobile_verified": mobile_verified,
    "kyc_completed": kyc_completed,
    "verificationFlow": verificationFlow,
    "accessToken": accessToken,
    "identityType": identityType,
    "externalUserId": externalUserId,
    "kycProviderKey": kycProviderKey,
  };
}
class NotificationPreference {
  String? title;
  String? key;
  bool? value;

  NotificationPreference({
    this.title,
    this.key,
    this.value,
  });

  factory NotificationPreference.fromJson(Map<String, dynamic> json) => NotificationPreference(
    title: json["title"],
    key: json["key"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "key": key ,
    "value": value ,
  };
}

