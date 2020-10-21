import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class PushNotificationsManager {

  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  final String serverToken = 'AAAALL6M61w:APA91bF8qc7HdkJAsbTUJ8R_lxU9i9AxKXMnPXSwmFzJjfERniHvX6b2VfTlZ1DYfWUVY1yhXQhh5h0FGqaLmukKQ7CKiviR1YeS8TOZaiDkp4ZS0ouMrOKaxydgK1TX7mFshE1VyIkS';

  static final PushNotificationsManager _instance = PushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;

  final _controller = StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get stream => _controller.stream;


  Future<void> init({GlobalKey<ScaffoldState> scaffoldkey}) async {
    if (!_initialized) {

      // For iOS request permission first.
      _firebaseMessaging.requestNotificationPermissions();
      _firebaseMessaging.configure();

      // For testing purposes print the Firebase Messaging token
      String token = await _firebaseMessaging.getToken();
      print("FirebaseMessaging token: $token");

      _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          if (message.containsKey('data')) {
            // Handle data message
            final dynamic data = message['data'];
          }

          if (message.containsKey('notification')) {
            // Handle notification message
            final dynamic notification = message['notification'];

            print("onMessage: $message");
            scaffoldkey.currentState.showSnackBar(
                SnackBar(
                    content: Container(
                        child: Row(
                          children: [
                            Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      Text(notification['title'])
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(notification['body'])
                                    ],
                                  )
                                ]
                            )
                          ],
                        )
                    ),
                    duration: Duration(seconds: 3)
                )
            );
          }
        },
        onLaunch: (Map<String, dynamic> message) async {
          print("onLaunch: $message");
        },
        onResume: (Map<String, dynamic> message) async {
          print("onResume: $message");
        },
      );
      _firebaseMessaging.requestNotificationPermissions(
          const IosNotificationSettings(
              sound: true, badge: true, alert: true, provisional: true));
      _firebaseMessaging.onIosSettingsRegistered
          .listen((IosNotificationSettings settings) {
        print("Settings registered: $settings");
      });

      _initialized = true;


    }
  }

  Future<void> sendAndRetrieveMessage() async {
    await _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: false),
    );
    final token = await _firebaseMessaging.getToken();
    http.Response response = await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': 'this is a body',
            'title': 'this is a title'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': token,
        },
      ),
    );

  }
}