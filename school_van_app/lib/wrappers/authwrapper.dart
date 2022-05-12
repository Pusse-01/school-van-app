import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_van_app/auth/accountselect.dart';
import 'package:school_van_app/auth/logindriver.dart';
import 'package:school_van_app/screens/driver/driverhome.dart';
import 'package:school_van_app/locationservice/mapservice.dart';

class authwrapper extends StatefulWidget {
  const authwrapper({Key? key}) : super(key: key);

  @override
  _authwrapperState createState() => _authwrapperState();
}

class _authwrapperState extends State<authwrapper> {
  @override
  Widget build(BuildContext context) {
    final currentuser = Provider.of<User?>(context);

    if (currentuser == null) {
      return logindriver();
    } else {
      return driverhome();
    }
  }
}
