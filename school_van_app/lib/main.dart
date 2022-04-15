import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_van_app/auth/accountselect.dart';
import 'package:school_van_app/auth/logindriver.dart';
import 'package:school_van_app/auth/loginparent.dart';
import 'package:school_van_app/auth/regdriver.dart';
import 'package:school_van_app/locationservice/mapservice.dart';
import 'package:school_van_app/models/location.dart';
import 'package:school_van_app/services/authentication.dart';
import 'package:school_van_app/wrappers/authwrapper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
 runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  StreamProvider<User?>.value(value: authService().user,catchError:(_,__){},  initialData: null,
      child:MaterialApp(
        home:authwrapper()
    )
    );
  }
}

