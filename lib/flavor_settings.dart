import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:urbandrop/core/utils/app_url.dart';

enum FlavorType { PROD, DEV }

class FlavorSettings {
  static FlavorType flavor = FlavorType.DEV;

  FlavorSettings() {}

  static Future<void> init() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    print("packageInfo.packageName:${packageInfo.packageName}");
    switch (flavor) {
      case FlavorType.PROD:
        flavor = FlavorType.PROD;
        websiteBaseURL = "https://showout.studio/cards/";
         apiKey = "byeUCKp3uHzTrB73PniEDCYpq6kzMVA9";
        FlavorConfig(variables: {"baseUrl": AppUrl.liveBaseURL});
        break;
      default:
        // flavor = FlavorType.PROD;
        // FlavorConfig(variables: {"baseUrl": AppUrl.liveBaseURL});
        flavor = FlavorType.DEV;
        websiteBaseURL = "https://dev.showout.studio/cards/";
         apiKey = "fgy6435678hghytr534qwe567890poijhgyftr543wesdrtfyu";
        FlavorConfig(
            name: "TEST",
            color: Colors.red,
            location: BannerLocation.topStart,
            variables: {"baseUrl": AppUrl.qaBaseURL});
    }
    // print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    // print(FlavorConfig.instance.variables['baseUrl']);
  }

  static String get apiBaseUrl {
    return FlavorConfig.instance.variables['baseUrl'];
  }

  static bool get isDev {
    return flavor == FlavorType.DEV;
  }
}
