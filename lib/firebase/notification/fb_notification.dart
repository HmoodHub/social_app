import 'package:firebase_messaging/firebase_messaging.dart';

class FBNotification{
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static Future<void> initNotification()async{
    NotificationSettings settings = await _messaging.requestPermission();
    print('User granted permission: ${settings.authorizationStatus}');
    String? token = await _messaging.getToken();
    print('$token');
    FirebaseMessaging.onMessage.listen(_firebaseMessagingOnMessagingHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_firebaseMessagingOnMessageOpenedAppHandler);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
    print("Handling a background message title: ${message.notification!.title}");
    print("Handling a background message body: ${message.notification!.body}");
    print("Handling a background message data: ${message.data}");
  }

  static Future<void> _firebaseMessagingOnMessagingHandler(RemoteMessage message) async {
    print(message.data.toString());
  }
  static Future<void> _firebaseMessagingOnMessageOpenedAppHandler(RemoteMessage message) async {
    print(message.data.toString());
  }
}