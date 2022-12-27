import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:socialcarpooling/provider/PushNotification.dart';

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log("Handling a background message: ${message.notification}");
}

class FirebaseNotification {
  late final FirebaseMessaging _messaging;
  PushNotification? _notificationInfo;

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log("User granted permission");
      listenForMessage();
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log("User granted provisional permission");
    } else {
      log("User declined or has not accepted permission");
    }
  }

  void registerNotification() async {
    // 1. Initialize the Firebase app
    await Firebase.initializeApp();
    await FirebaseMessaging.instance.getToken();
    // 2. Instantiate Firebase Messaging
    _messaging = FirebaseMessaging.instance;

    // Add the following line
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted permission');
      listenForMessage();
    } else {
      log('User declined or has not accepted permission');
      requestPermission();
    }
  }

  void listenForMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log("On Message received $message");
      parseRemoteMessage(message);
      log("_Notification Info is $_notificationInfo");
    });
  }

  void handleBackgroundNotification() {
    // For handling notification when the app is in background
    // but not terminated
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PushNotification notification = PushNotification(
        title: message.notification?.title,
        body: message.notification?.body,
      );
      _notificationInfo = notification;
    });
  }

  // For handling notification when the app is in terminated state
  checkForInitialMessage() async {
    await Firebase.initializeApp();
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      parseRemoteMessage(initialMessage);
    }
  }

  void parseRemoteMessage(RemoteMessage message) {
    PushNotification notification = PushNotification(
      title: message.notification?.title,
      body: message.notification?.body,
    );
    _notificationInfo = notification;
    showSimpleNotificationView();
  }

  void showSimpleNotificationView() {
    if (_notificationInfo != null) {
      // For displaying the notification as an overlay
      showSimpleNotification(
        Text(_notificationInfo!.title!),
        subtitle: Text(_notificationInfo!.body!),
        background: Colors.cyan.shade700,
        duration: const Duration(seconds: 2),
      );
    }
  }
}
