// class NotificationElancer{
//
// }

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //BACKGROUND Notification - IOS & Android
  await Firebase.initializeApp();
  print('Message: ${message.messageId}');
}

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin localNotificationsPlugin;

mixin FbNotification {
  /// CALLED IN main function between ensureInitialized <-> runApp(widget)
  static Future<void> initNotification() async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    print('FCM TOKEN: $fcmToken');
    //Connect the previous created function with onBackgroundMessage to enable
    //receiving notification when app in background.
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    /**
     * You should be add to manifest this plugins
     * in application tag
     *    <meta-data
     *    android:name="com.google.firebase.messaging.default_notification_channel_id"
     *    android:value="name_notification_channel"
     *    />
     * and you should be add value from meta-data in id in AndroidNotificationChannel
     */
    //Channel
    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'social_notification_channel',
        'social notification channel',
        description:
            'This channel will receive notification specific to social_app',
        importance: Importance.high,
        enableLights: true,
        enableVibration: true,
        ledColor: Colors.red,
        showBadge: true,
        playSound: true,
      );
    }

    //Flutter Local Notification Plugins (FOREGROUND) - ANDROID CHANNEL
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    //IOS Notification Setup (FOREGROUND)
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      sound: true,
      badge: true,
    );
  }

  //IOS Notification Permission
  Future<void> requestNotificationPermission() async {
    print('requestNotificationPermission');
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      announcement: false,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('GRANT PERMISSION');
    } else if (settings.authorizationStatus == AuthorizationStatus.denied) {
      print('DENIED PERMISSION');
    }
  }

  //ANDROID
  void initializeForegroundNotificationForAndroid() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Message Receive: ${message.messageId}');
      RemoteNotification? notification = message.notification;
      AndroidNotification? androidNotification = notification?.android;
      if (notification != null && androidNotification != null) {
        localNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: 'launch_background',
            ),
          ),
        );
      }
    });
  }

  //GENERAL (Android & IOS)
  void manageNotificationAction() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message){
      _controlNotificationNavigation(message.data);
    });
  }

  void _controlNotificationNavigation(Map<String, dynamic> data) {
    print('Data: $data');
    // Example...
    if (data['page'] != null) {
      switch(data['page']) {
        case 'product':
          var productId = data['id'];
          print('Product Id: $productId');
          break;
        case 'settings':
          print('Go to settings');
          break;
        default:
      }
        
    }  
  }
}
