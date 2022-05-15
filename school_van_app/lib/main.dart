import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:provider/provider.dart';
import 'package:school_van_app/screens/splash_screen.dart';
import 'package:school_van_app/services/authentication.dart';
import 'package:school_van_app/wrappers/authwrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final androidConfig = FlutterBackgroundAndroidConfig(
      notificationTitle: "School Van App",
      notificationText: "App is Running",
      notificationImportance: AndroidNotificationImportance.Default,
      notificationIcon: AndroidResource(
          name: 'background_icon',
          defType: 'drawable'), // Default is ic_launcher from folder mipmap
      enableWifiLock: false);
  bool success =
      await FlutterBackground.initialize(androidConfig: androidConfig);
  await FlutterBackground.enableBackgroundExecution();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
        value: authService().user,
        catchError: (_, __) {},
        initialData: null,
        child: MaterialApp(home: SplashScreen()));
  }
}
