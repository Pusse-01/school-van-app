import 'package:flutter/material.dart';

class Driver_profile extends StatefulWidget {
  const Driver_profile({Key? key}) : super(key: key);

  @override
  State<Driver_profile> createState() => _Driver_profileState();
}

class _Driver_profileState extends State<Driver_profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [Text("Profile")],
      ),
    );
  }
}
