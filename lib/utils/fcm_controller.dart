import 'package:firebase_messaging/firebase_messaging.dart';

class FCMController {
  final FirebaseMessaging fcm;

  FCMController(this.fcm) {
    print('=============================================');
    print('[CONSTRUCTOR] FCMController');
    print('=============================================');
    print('');
  }

  Future<void> requestPermission() async {
    print('=============================================');
    print('[FUNC CALL] FCMController.requestPermission');
    print('=============================================');
    print('');

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
        print('=============================================');
        print('* AuthorizationStatus : ${AuthorizationStatus.authorized}');
        print('=============================================');
        print('');
      } else if (notificationSettings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        print('=============================================');
        print('* AuthorizationStatus : ${AuthorizationStatus.provisional}');
        print('=============================================');
        print('');
      } else {
        print('=============================================');
        print('* AuthorizationStatus : ${AuthorizationStatus.denied}');
        print('=============================================');
        print('');
      }
    }
  }

  Future<void> getMessage() async {
    print('=============================================');
    print('[FUNC CALL] FCMController.getMessage');
    print('=============================================');
    print('');

    RemoteMessage? message = await fcm.getInitialMessage();

    print('* Data returned from fcm.getInitialMessage() : ${message?.data}');
    print('=============================================');
    print('');
  }
}
