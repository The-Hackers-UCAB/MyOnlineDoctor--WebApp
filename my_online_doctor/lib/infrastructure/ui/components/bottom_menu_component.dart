//Package imports:
// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'dart:convert';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_online_doctor/infrastructure/core/context_manager.dart';
import 'package:my_online_doctor/infrastructure/core/firebase-handler/local_notifications.dart';
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';
import 'package:my_online_doctor/infrastructure/ui/components/dialog_component.dart';

//Project imports:
import 'package:my_online_doctor/infrastructure/ui/styles/colors.dart';
import 'package:my_online_doctor/infrastructure/ui/video_call/call.dart';

//Define a global boolean
bool isSwitched = false;
//define a global BuildContext
BuildContext globalContext = getIt<ContextManager>().context;
late String globalChannel;
late RemoteMessage globalMessage;
bool isVideoCall = false;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class BottomMenuComponent extends StatefulWidget {
  static const routeName = '/bottom_menu';

  final items;
  final screens;
  int index;

  BottomMenuComponent({
    Key? key,
    required this.items,
    required this.screens,
    required this.index,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BottomMenuComponent();
}

Future<void> selectNotification(String? payload) async {
  // debugPrint('Este vendria siendo el channel: $globalChannel');
  debugPrint('Este vendria siendo la data del mensaje: ${globalMessage.data}');
  // debugPrint(globalMessage.data.toString());
  var jsonResponse = globalMessage.data['payload'];
  var decoded = json.decode(jsonResponse);
  if (isVideoCall) {
    debugPrint('Es una llamada');

    if (payload != null) {
      await showDialog(
          context: globalContext,
          builder: ((BuildContext dialogcontext) {
            return DynamicDialog(
                title: globalMessage.notification!.title,
                body: globalMessage.notification!.body);
          }));
      //This works only if the app is in the foreground
      if (isSwitched) {
        // ignore: use_build_context_synchronously
        await Navigator.push(
          globalContext,
          MaterialPageRoute(
            builder: (BuildContext rootContext) => CallPage(
              channelName: globalChannel,
              role: ClientRole.Broadcaster,
            ),
          ),
        );
      }
    }
  } else {
    // TODO: Implementar que sea una notificacion de otra cosa y que haga otra cosa
    debugPrint('Es un mensaje, pero no de llamada');
  }
}

Future<void> recieveNotification(RemoteMessage message) async {
  if (message == null) {
    return;
  }
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  const AndroidNotificationChannel channelA = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // titletion
    importance: Importance.high,
  );
  if (notification != null && android != null) {
    var initializationSettings = const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'));
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: ((payload) => selectNotification(globalChannel)));
    await flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channelA.id,
            channelA.name,
            icon: android.smallIcon,
          ),
        ));
  }
}

class _BottomMenuComponent extends State<BottomMenuComponent> {
  _BottomMenuComponent();

  @override
  void initState() {
    localNotificationService.initialize();
    // notify();
    super.initState();
    //Terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        localNotificationService.showNotificationOnForeground(message);
      }
      print('Hola soy el 1');
    });

    //Foreground state
    FirebaseMessaging.onMessage.listen((message) async {
      // FirebaseMessaging.onBackgroundMessage(backgroundHandler);
      globalMessage = message;
      localNotificationService.showNotificationOnForeground(message);
      var payload = message.data['payload'];
      if (!json.decode(payload).containsKey('channelName')) {
        isVideoCall = false;
        await recieveNotification(message);
      } else {
        isVideoCall = true;
        globalChannel = json.decode(payload)['channelName'];
        await recieveNotification(message);
      }
    });
    //Background state
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      localNotificationService.showNotificationOnForeground(message);

      globalMessage = message;

      var payload = message.data['payload'];
      if (!json.decode(payload).containsKey('channelName')) {
        isVideoCall = false;
        await recieveNotification(message);
      } else {
        isVideoCall = true;
        globalChannel = json.decode(payload)['channelName'];
        await recieveNotification(message);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    globalContext = context;
    return Scaffold(
      body: widget.screens[widget.index],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: const IconThemeData(color: colorWhite),
        ),
        child: CurvedNavigationBar(
          color: colorSecondary,
          index: widget.index,
          items: widget.items,
          height: MediaQuery.of(context).size.height * 0.07,
          buttonBackgroundColor: colorPrimary,
          backgroundColor: colorWhite,
          onTap: (newIndex) => setState(() {
            widget.index = newIndex;
          }),
        ),
      ),
    );
  }
}

class DynamicDialog extends StatefulWidget {
  final title;
  final body;
  DynamicDialog({this.title, this.body});
  @override
  _DynamicDialogState createState() => _DynamicDialogState();
}

class _DynamicDialogState extends State<DynamicDialog> {
  @override
  static late bool Call;
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      actions: <Widget>[
        OutlinedButton.icon(
            label: const Text(''),
            onPressed: () {
              Navigator.pop(context);
              isSwitched = false;
            },
            icon: const Icon(Icons.call_end, color: Colors.redAccent)),
        OutlinedButton.icon(
            label: const Text(''),
            onPressed: () {
              Navigator.pop(context);
              isSwitched = true;
            },
            icon: const Icon(Icons.call, color: Colors.greenAccent)),
      ],
      content: Text(widget.body),
    );
  }
}
