import 'package:flutter/material.dart';
import 'package:school_van_app/screens/parents/parents_dashboard.dart';
import 'package:school_van_app/screens/parents/parents_map.dart';
import 'package:school_van_app/screens/parents/parents_profile.dart';

class Parent_Home extends StatefulWidget {
  const Parent_Home({Key? key}) : super(key: key);

  @override
  State<Parent_Home> createState() => _Parent_HomeState();
}

class _Parent_HomeState extends State<Parent_Home> {
  int _selected = 0;
  bool started = false;
  static const List<Widget> _widgetOptions = <Widget>[
    Parent_Dashboard(),
    Parents_map(),
    Parents_profile(),
  ];
  void _ontapped(int index) {
    setState(() {
      _selected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.indigo[400],
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.white,
        currentIndex: _selected,
        onTap: _ontapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            label: "Home",
            backgroundColor: Color(0xff4E8CDD),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined),
            label: "Map",
            backgroundColor: Color(0xff4E8CDD),
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.airport_shuttle_outlined),
          //   label: "Kids",
          //   backgroundColor: Colors.indigo[600],
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_sharp),
            label: "Profile",
            backgroundColor: Color(0xff4E8CDD),
          )
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selected),
      ),
    );
  }
}
