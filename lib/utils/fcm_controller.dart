import 'package:firebase_messaging/firebase_messaging.dart';

class FCMController {
  final FirebaseMessaging fcm;

  FCMController(this.fcm);

  Future<void> requestPermission() async {
    NotificationSettings previousSettings = await fcm.getNotificationSettings();

    if (previousSettings.authorizationStatus ==
        AuthorizationStatus.notDetermined) {
      NotificationSettings notificationSettings = await fcm.requestPermission(
          alert: true,
          announcement: true,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: false,
          sound: true);

      if (notificationSettings.authorizationStatus ==
          AuthorizationStatus.authorized) {
        print('User granted permission');
      } else if (notificationSettings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        print('User granted provisional permission');
      } else {
        print('User declined or has not accepted permission');
      }
    }
  }

  Future<void> getMessage() async {
    RemoteMessage? message = await fcm.getInitialMessage();

    print('getInitialMessage() called !');
    print(message?.data);
  }
}
