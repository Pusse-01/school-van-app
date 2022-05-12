import 'package:flutter/material.dart';

class Child_Info extends StatefulWidget {
  const Child_Info({Key? key}) : super(key: key);

  @override
  State<Child_Info> createState() => _Child_InfoState();
}

class _Child_InfoState extends State<Child_Info> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [Text("Childs")],
      ),
    );
  }
}
