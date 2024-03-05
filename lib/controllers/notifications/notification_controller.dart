import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:urbandrop/controllers/notifications/notification_actions_manager.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';



class NotificationController{
  NotificationController({required this.context});
  BuildContext context;


  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future initialise() async{
    print("initialise");
    if(Platform.isIOS){
      print("initialise ios");
      NotificationSettings settings = await _fcm.requestPermission(
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

    await FirebaseMessaging.instance.subscribeToTopic("topic");
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async{
      print('Message data3: ${message.data}');
      if (message.notification != null) {
        print('Message also contained a notification1: ${message.data}');
      }
      // instantNotification(message.notification!.body!,message.notification!.title!,jsonEncode(message.data),);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: InkWell(
              onTap: ()async{
                NotificationsActionsManager? _notificationsActionsManager;
                _notificationsActionsManager = NotificationsActionsManager.getInstance(context);
                await  _notificationsActionsManager!.performAction(varag: message.data);

              },
              child: Row(
                children: [
                   ClipRRect(
                     borderRadius: BorderRadius.circular(5),
                     child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(0)),child: Image.asset("assets/images/ic_launcher.png",width: 35,height: 35,),
                     ),
                   ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message.notification!.title!,
                          style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 0,),
                        SizedBox(
                          width: appWidth(context) * 0.75,
                          child: Text(
                            message.notification!.body!,
                            maxLines: 1,
                            style: const TextStyle(color: Colors.white,),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: appMainColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: appMainColor),
            ),
            showCloseIcon: true,
            closeIconColor: Colors.white,
            dismissDirection: DismissDirection.down,
            duration: const Duration(seconds: 1),
            behavior: SnackBarBehavior.floating,
            margin:  EdgeInsets.only(bottom: appHeight(context) * 0.7, left: 20, right: 20)
        ),
      );
    });
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      // state.notified.value = true;
      print('Got a message whilst in the onlunch!');
      print('Message data2: ${message.data}');
      NotificationsActionsManager? _notificationsActionsManager;
      _notificationsActionsManager = NotificationsActionsManager.getInstance(context);
      await  _notificationsActionsManager!.performAction(varag: message.data);

    });
    _fcm.getToken().then((String? token) async{
      assert(token != null);
      print("Push Messaging token gcid: $token");
      // await AuthenticationController().updateUser({
      //   "gcid":token
      // }, context);

    });
  }

  void notificationTapReceive(NotificationResponse notificationResponse)async{
    // handle action
    print("notificationTapReceive afvfvsfs:${jsonDecode(notificationResponse.payload!)}");
    NotificationsActionsManager? _notificationsActionsManager;
    print("notificationTapReceive:${jsonDecode(notificationResponse.payload!)}");
    _notificationsActionsManager = NotificationsActionsManager.getInstance(context);
    print("notificationTapReceive:${jsonDecode(notificationResponse.payload!)}");
    await  _notificationsActionsManager!.performAction(varag: jsonDecode(notificationResponse.payload!));
  }

  Future initialize() async{
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings("ic_launcher");

    DarwinInitializationSettings iosInitializationSettings = DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    final InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings,
        iOS: iosInitializationSettings
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  }


  void requestPermissions() {
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
        critical: true

    );
  }
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void>firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  // await Firebase.initializeApp();
  print("background message:${message.data}");
  if(message.data.isNotEmpty){
    instantNotification(message.notification!.body!,message.notification!.title!,jsonEncode(message.data),);
  }
  return;

}

void notificationTapBackground(NotificationResponse notificationResponse) async{
  // handle action
  // print("notificationTapBackground:${notificationResponse.input}");
  // NotificationsActionsManager? _notificationsActionsManager;
  // _notificationsActionsManager = NotificationsActionsManager.getInstance(context);
  // await _notificationsActionsManager!.performAction(varag: jsonDecode(notificationResponse!.payload!));
}


Future instantNotification(String message,String title,String payload) async{
  var android = const AndroidNotificationDetails(
      "id", "channel",channelDescription: "description",priority: Priority.high, importance: Importance.max,
      playSound: true,
      sound: RawResourceAndroidNotificationSound("slow_spring_board"),
      icon: "ic_launcher",
      ticker: 'ticker',
      color: appMainColor,
      channelShowBadge: true,
      colorized: true,
      enableVibration: true,
      showWhen: true
  );

  var ios = DarwinNotificationDetails(sound: 'slow_spring_board.aiff',presentBadge: true,presentAlert: true,presentSound: true,);

  var platforms = new NotificationDetails(android: android, iOS: ios);

  await flutterLocalNotificationsPlugin.show(0, "$title", "$message", platforms,payload: payload,);
}