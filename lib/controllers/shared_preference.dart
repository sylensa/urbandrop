import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urbandrop/controllers/dashboard/dashboard_controller.dart';
import 'package:urbandrop/controllers/orders/orders_controller.dart';
import 'package:urbandrop/controllers/products/product_controllers.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/helper/hide.dart';
import 'package:urbandrop/models/user.dart';


String FORCE_UPDATE = "shouldForceUpdate";

class UserPreferences {
  static late SharedPreferences _prefs;

  static set prefs(SharedPreferences prefs) => _prefs = prefs;

  static SharedPreferences get instance => _prefs;
  static String? get accessToken => _prefs.getString("token");
  static String? get refreshToken => _prefs.getString("refresh_token");
  static bool? get getSeenAdd => _prefs.getBool("seenAdd") ?? false;
  static bool get isLoggedIn => accessToken != null && accessToken != '';
  Future setSeenOnboard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('seenOnboard', true);
    return true;
  }

  Future setSeenAdd() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('seenAdd', true);
    return true;
  }

  Future setSeenRoyalty({bool status = false}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('seenRoyalty', status);
    return true;
  }


  Future<List<String>> getSearchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getStringList('setSearchHistory');
    return  prefs.getStringList('setSearchHistory') ?? [];
  }

  Future getSeenOnboard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('seenOnboard') ?? false;
  }

  Future getSeenRoyalty() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('seenRoyalty') ?? false;
  }

  Future<bool> setUser(var user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user", jsonEncode(user));
    return true;
  }


  setViewedPlaylist() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("viewedPlaylist", true);
    return true;
  }

  Future<bool> getViewedPlaylist() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool viewedPlaylist = prefs.getBool("viewedPlaylist") ?? false;
    return viewedPlaylist;
  }


  Future<UserModel?> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user = prefs.getString("user");
    log("user:$user");
    UserModel? userInfo;
    if(user != null){
      userInfo = UserModel.fromJson(jsonDecode(user));
      userInstance = userInfo;
    }
    return userInfo;
  }

   removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  removeKey() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("setSearchHistory");
    prefs.remove("setCardSearchHistory");
  }

  Future<String?> getUserToken() async {
    userToken = await getUserValue("token");
    return await getUserValue("token");
  }

  Future<String?> getUserRefreshToken() async {
    return getUserValue("refresh_token");
  }

  Future<int?> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? value = prefs.getInt("id");
    return value;
  }

  Future<String?> getUserValue(args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString(args);
    return value;
  }


  Future<int?> getIntValue(args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? value = prefs.getInt(args);
    return value;
  }


  Future<bool> shouldForceUpdate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(FORCE_UPDATE) ?? false;
  }

  Future<bool> setShouldForceUpdate(bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setBool(FORCE_UPDATE, value);
  }

  setToken(String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    log("setting new token token:${value}");
    preferences.setString('token', value);
  }

  setRefreshToken(String value) async {
    log("setting new refresh_token:${value}");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('refresh_token', value);
  }

  getPushNotificationToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString('pushNotificationToken');
    print('push notification token => $token');
    return token;
  }

  setPushNotificationToken(String value) async {
    print("pushNotificationToken:$value");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('pushNotificationToken', value);
  }

  getHasRegisteredDevice() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool("hasRegisteredDevice") ?? false;
  }

  setHasRegisteredDevice(bool hasRegisteredDevice) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("hasRegisteredDevice", hasRegisteredDevice);
  }

  logout() async {
    Get.reset();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    await clearPrefs();
  }
}
