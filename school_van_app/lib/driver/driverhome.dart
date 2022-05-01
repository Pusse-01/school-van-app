import 'package:flutter/material.dart';
import 'package:school_van_app/driver/driverhomefile.dart';
import 'package:school_van_app/locationservice/mapservice.dart';

class driverhome extends StatefulWidget {
  const driverhome({Key? key}) : super(key: key);

  @override
  State<driverhome> createState() => _driverhomeState();
}

class _driverhomeState extends State<driverhome> {
  int _selected=0;
  bool started=false;
  void _ontapped(int index){
    setState(() {
      _selected=index;
    });
  }



  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body: Container(
            child:<Widget>[
              driversH(indexhange: _ontapped,),
              locationfind()
            ].elementAt(_selected)
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.indigo[400],
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Colors.white,
          currentIndex:_selected ,
          onTap: _ontapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined,),
              label: "Home",
              backgroundColor: Colors.indigo[400],



            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on_outlined),
              label: "Map",
              backgroundColor: Colors.indigo[500],

            ),


            BottomNavigationBarItem(
              icon: Icon(Icons.airport_shuttle_outlined),
              label: "Kids",
              backgroundColor: Colors.indigo[600],

            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_sharp),
              label: "Profile",
              backgroundColor: Colors.indigo[700],

            )
          ],
        ),
      );
  }
}

