import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:urbandrop/controllers/shared_preference.dart';
import 'package:urbandrop/core/helper/helper.dart';


class PushNotificationManager {
  static Future<dynamic> backgroundMessageHandler(RemoteMessage message) async {
    if (message.notification != null) {
      return message;
    }
  }

  PushNotificationManager._();

  factory PushNotificationManager() => _instance;

  static final PushNotificationManager _instance = PushNotificationManager._();

  static NotificationViewType _notificationViewType =
      NotificationViewType.foreground;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  // bool _initialized = true;

  Future<void> listen({Function(RemoteMessage message, NotificationViewType notificationViewType)?messageHandler}) async {

    if(Platform.isIOS){
      print("initialise ios");
      NotificationSettings settings = await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      print('User granted permission: ${settings.authorizationStatus}');
    }


    UserPreferences userPreferences = UserPreferences();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('### Foreground Message');
      debugPrint('Message data: ${message.data}');

      if (message.notification != null) {
        ///show the message title

        //call the message handler with the message
        // from the push notificaion
        _notificationViewType = NotificationViewType.foreground;
        messageHandler!(message, _notificationViewType);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('### onMessageOpenedApp');
      debugPrint('Message data: ${message.data}');
      _notificationViewType = NotificationViewType.background;
      messageHandler!(message, _notificationViewType);
    });

    FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);

    _firebaseMessaging.onTokenRefresh.listen((newToken) async {
      // final UserModel? user = await userPreferences.getUser();
      // if(user != null){
      //   if (user.isActive!) {
      //     final oldToken =  user.gcid;
      //     if (oldToken != newToken) {
      //       await authenticationController.refreshToken(oldToken: oldToken, newToken: newToken);
      //     }
      //   }
      // }

    });
  }
}
