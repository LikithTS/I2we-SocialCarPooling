

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common/network/repository/FirebaseRepository.dart';
import 'package:common/network/request/FirebaseTokenApi.dart';
import 'package:common/utils/CPSessionManager.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseTokenUpdate {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  String channelId = "";
  String channelName = "";
  FirebaseRepository firebaseRepository = FirebaseRepository();

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      log("My token is $token");
      saveToken(token);
      updateFirebaseToken(token);
      return token;
    });
  }

  void saveToken(String? token) async {
    if (token != null && token.isNotEmpty) {
      log("Saving the token");
      await FirebaseFirestore.instance
          .collection("UserTokens")
          .doc(CPSessionManager().getUserId())
          .set({
        'token': token,
      });
    }
  }

  void updateFirebaseToken(String? token) {
    if (token != null && token.isNotEmpty) {
      FirebaseTokenApi api = FirebaseTokenApi(token: token);
      Future<dynamic> future = firebaseRepository.updateFirebaseToken(api: api);
      future.then((value) => {handleFirebaseTokenResponseData(value)});
    }
  }

  handleFirebaseTokenResponseData(value) {
    log("Firebase token is success");
  }

  initInfo() {
    var androidInitialize =
        const AndroidInitializationSettings("@mipmap/ic_launcher");
    //Enable this when xcode is added
    // var iosInitialize = const IOSInitializationSettings();
    var initializationsSettings =
        InitializationSettings(android: androidInitialize); // Add IOS later
    flutterLocalNotificationsPlugin.initialize(initializationsSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      log("OnMessage : ${message.notification?.title} and ${message.notification?.body}");

      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
        message.notification!.body.toString(),
        htmlFormatBigText: true,
        contentTitle: message.notification!.title.toString(),
        htmlFormatContentTitle: true,
      );

      AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(channelId, channelName,
              importance: Importance.high,
              styleInformation: bigTextStyleInformation,
              priority: Priority.high,
              playSound: true);

      NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.show(0, message.notification?.title,
          message.notification?.body, platformChannelSpecifics,
          payload: message.data['title']);
    });
  }
}
