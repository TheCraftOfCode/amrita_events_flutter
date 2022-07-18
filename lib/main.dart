import 'package:amrita_events_flutter/screens/greeting_page.dart';
import 'package:amrita_events_flutter/screens/the_main.dart';
import 'package:amrita_events_flutter/widgets/load_valid_page_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:oktoast/oktoast.dart';
import 'firebase_options.dart';
import 'package:amrita_events_flutter/utils/colors.dart' as colors;

//TODO: Configure APNs for iOS notification
//reference: https://firebase.flutter.dev/docs/messaging/apple-integration/

//TODO: Fix bug in progress wheel in management pages
//TODO: Add place holder widgets for management pages (empty)
//TODO: Add progress wheel for notifications page (list)

//TODO: Add download CSV file in manage RSVP and also add place holder for RSVP console, add stats in RSVP console
//TODO: Add toasts

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const OKToast(position: ToastPosition.center, child: App()));
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  Future<void> initNotification() async {
    print("INIT");
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print(fcmToken);
    final FirebaseMessaging messaging = FirebaseMessaging.instance;

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'amrita_events_notification_channel', // id
      'Amrita Events Notifications', // title
      description: 'This channel is used for amrita events notifications.',
      // description
      importance: Importance.max,
    );

    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    messaging.subscribeToTopic('main');

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    FlutterLocalNotificationsPlugin().initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channelDescription: channel.description,
                  icon: android.smallIcon,
                ),
                iOS: const IOSNotificationDetails(
                  presentAlert: true,
                  // Present an alert when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
                  presentSound:
                      true, // Play a sound when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
                )));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("_messaging onMessageOpenedApp: $message");
    });
  }

  @override
  void initState() {
    super.initState();
    initNotification();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: colors.accentColor, secondary: colors.accentColor)),
      home: const LoadValidPageWidget(GreetingPage(), TheMain()),
    );
  }
}
