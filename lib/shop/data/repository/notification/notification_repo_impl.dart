import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

/// A top-level function to handle background messages.
///
/// This function is called when the app is in the background or terminated
/// and receives a push notification. It can be used to handle background
/// notifications and perform necessary actions when the app is not active.
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  diInstance.get<NotificationRepo>().showLocalNotification(message);
}

/// The implementation of the NotificationRepo abstract class.
class NotificationRepoImpl implements NotificationRepo {
  StreamSubscription? onMessageReceivedSubscription;
  StreamSubscription? onNotificationOpened;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final AndroidNotificationChannel _channel = const AndroidNotificationChannel(
    'test_notification_channel',
    'Test Notification Channel',
    importance: Importance.max,
  );

  @override
  Future<void> initializeConfig() async {
    final isAllowed = await _requestNotificationPermissions();
    if (isAllowed) {
      debugPrint('-----> Token: ${await getToken()}');
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      if (Platform.isAndroid) {
        await _configureAndroidForeground();
        await onForegroundNotificationReceived();
      }
      _onNotificationOpenedApp();
    }
    _configureLocalNotifications();
  }

  @override
  Future<String?> getToken() {
    return FirebaseMessaging.instance.getToken();
  }

  @override
  Future<void> onForegroundNotificationReceived() async {
    onMessageReceivedSubscription?.cancel();

    onMessageReceivedSubscription =
        FirebaseMessaging.onMessage.listen(showLocalNotification);
  }

  @override
  Future<void> subscribeToTopic(String topic) async {
    try {
      await FirebaseMessaging.instance.subscribeToTopic(topic);
    } catch (error, stackTrace) {
      print(error);
    }
  }

  Future<bool> _requestNotificationPermissions() async {
    if (Platform.isIOS) {
      return _requestIOSPermissions();
    } else {
      return _requestAndroidPermissions();
    }
  }

  Future<bool> _requestAndroidPermissions() async {
    bool? result = true;
    try {
      await flutterLocalNotificationsPlugin.initialize(
        const InitializationSettings(
          android: AndroidInitializationSettings('image'),
        ),
      );

      result = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestPermission();
    } catch (exception, stacktrace) {
      debugPrint(exception.toString());
    }

    return result ?? true;
  }

  Future<bool> _requestIOSPermissions() async {
    final settings = await FirebaseMessaging.instance.requestPermission();
    return settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;
  }

  Future<void> _configureLocalNotifications() async {
    if (Platform.isIOS) {
      FirebaseMessaging.onMessage.listen(showLocalNotification);
    } else if (Platform.isAndroid) {
      FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
      FirebaseMessaging.instance.getInitialMessage().then((message) {
        if (message != null) {
          showLocalNotification(message);
        }
      });
    }
  }

  Future<void> _onNotificationOpenedApp() async {
    onNotificationOpened?.cancel();
    onNotificationOpened = FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {},
    );
  }

  Future<void> _configureAndroidForeground() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);
  }

  @override
  Future<void> showLocalNotification(RemoteMessage message) async {
    const int notificationId = 0;
    final androidNotificationProps = message.notification?.android;
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      _channel.id,
      _channel.name,
      icon: androidNotificationProps?.smallIcon,
      importance: Importance.max,
      priority: Priority.max,
      ticker: 'ticker',
    );

    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      notificationId,
      message.notification?.title ?? '',
      message.notification?.body ?? '',
      platformChannelSpecifics,
    );
  }
}
