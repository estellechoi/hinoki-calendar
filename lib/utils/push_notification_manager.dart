import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationManager {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future<void> listenPushNotification() async {
    // 종료 상태인 앱이 열리도록 한 메세지를 가져옵니다.
    RemoteMessage? message = await firebaseMessaging.getInitialMessage();

    if (message?.data['type'] == 'chat') {
      // .. 원하는 라우트로 이동
    }
  }

  Future<NotificationSettings> getFCMPermissionStatus() async {
    NotificationSettings previousSettings =
        await firebaseMessaging.getNotificationSettings();

    if (previousSettings.authorizationStatus ==
        AuthorizationStatus.notDetermined) {
      NotificationSettings notificationSettings =
          await firebaseMessaging.requestPermission(
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

      return notificationSettings;
    }

    return previousSettings;
  }
}
