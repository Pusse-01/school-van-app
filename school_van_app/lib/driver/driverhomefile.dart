import 'package:flutter/material.dart';

class driversH extends StatefulWidget {
  final indexhange ;
  const driversH({Key? key,this.indexhange}) : super(key: key);

  @override
  State<driversH> createState() => _driversHState();
}

class _driversHState extends State<driversH> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: SafeArea(
          child:Container(
            child: Column(
              children: [
                ElevatedButton(onPressed:()=>widget.indexhange(1), child:Text('Start'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
