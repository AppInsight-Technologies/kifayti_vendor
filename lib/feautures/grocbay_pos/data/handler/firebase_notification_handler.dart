import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../injection_container.dart';




class FirebaseNotifications {

  FirebaseMessaging? _firebaseMessaging;
  int? count = 0;
  GlobalKey<ScaffoldState>? scaffoldKey;
  late SharedPreferences prefs;

  Future<void> setUpFirebase() async {
    print("ghjk.....");
     prefs = await SharedPreferences.getInstance();
    _firebaseMessaging = FirebaseMessaging.instance;
    firebaseCloudMessaging_Listeners();
  }

  notificationConfig({
    Function(Map<String, dynamic>)? onresume,
    Function(Map<String, dynamic>)? onLaunch,
    Function(Map<String, dynamic>)? onMessage,
  }){

    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async{
      print('Got a message whilst in the Backgroound!');
      print('Message data: ${message.data}');
      onresume!(json.decode(json.encode(message.data)));
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onmessage print.....1");
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      onMessage!(json.decode(json.encode(message.data)));
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
    FirebaseMessaging.onMessageOpenedApp.forEach((element) {
      print("onmessage print.....2"+element.data.toString());

      onLaunch!(element.data);
    });
    // _firebaseMessaging!.configure(
    //   onMessage: (Map<String, dynamic> message) async=>onMessage!(json.decode(json.encode(message))),
    //   onResume: (Map<String, dynamic> message) async =>onresume!(json.decode(json.encode(message))),
    //   onLaunch: (Map<String, dynamic> message) async =>onLaunch!(json.decode(json.encode(message)),
    //   // onBackgroundMessage: myBackgroundMessageHandler
    // );
  }
  // ignore: non_constant_identifier_names
  void firebaseCloudMessaging_Listeners() {
    print("ghjk.....1");
    try{
      if(!Vx.isAndroid&&!Vx.isWeb) {
        iOS_Permission();
      }
    } catch(e){
    }

    _firebaseMessaging!.getToken().then((token) async {
      print("ghjk.....2.."+token.toString());
     prefs.setString("ftokenid", token!);
    //  sl<SharedPreferences>().setString("ftokenid",token.toString());
      print("tocken id: "+ token.toString());
    });

  }

  void iOS_Permission() async {
    NotificationSettings settings = await _firebaseMessaging!.requestPermission(
        provisional: true,
        sound: true,
        criticalAlert: false,
        carPlay: false,
        badge: true,
        alert: true
    );
  }
}