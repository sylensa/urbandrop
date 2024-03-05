// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:show_out/controllers/shared_preference.dart';
//
// class NotificationService {
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   UserPreferences userPreferences = UserPreferences();
//
//   static final NotificationService _notificationService = NotificationService._internal();
//
//   factory NotificationService() {
//     return _notificationService;
//   }
//
//   NotificationService._internal();
//
//   Future<void> init() async {
//     final AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('ic_launcher');
//     final IOSInitializationSettings initializationSettingsIos = IOSInitializationSettings();
//
//     final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIos);
//     String? token = await _firebaseMessaging.getToken();
//    await  userPreferences.setPushNotificationToken(token!);
//     print("token:$token");
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings,);
//   }
//
// }
