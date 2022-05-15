import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:school_van_app/screens/parents/parent_profile_main.dart';
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
  static List<Widget> _widgetOptions = <Widget>[
    Parent_Dashboard(),
    Parents_map(),
    ParentProfileMain(),
  ];
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  void _ontapped(int index) {
    index == 0
        ? _drawerKey.currentState?.openDrawer()
        : setState(() {
            _selected = index - 1;
            print(_selected);
          });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer: Drawer(
          backgroundColor: Color(0xfff1f3fa),
          child: ListView(
            // padding: EdgeInsets.zero,
            children: [
              Container(
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 250, 250, 251),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                          radius: MediaQuery.of(context).size.height * 0.06,
                          backgroundColor: Colors.amber,
                          foregroundImage:
                              AssetImage('assets/images/avatar.png')),
                      SizedBox(
                        height: 10,
                      ),
                      AutoSizeText(
                        "Peter De Almeida",
                        maxFontSize: 16,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                // margin: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                padding: EdgeInsets.all(12.0),
                // height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 1,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select your child",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Card(
                      color: Color(0xff4E8CDD),
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          debugPrint('Card tapped.');
                        },
                        child: SizedBox(
                          width: 300,
                          // height: 60,
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.amber,
                                    foregroundImage:
                                        AssetImage('assets/images/avatar.png')),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Yasodhya Perera',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Ananda College',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      color: Color(0xff4E8CDD),
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          debugPrint('Card tapped.');
                        },
                        child: SizedBox(
                          width: 300,
                          // height: 60,
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.amber,
                                    foregroundImage:
                                        AssetImage('assets/images/avatar.png')),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Yasodhya Perera',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Ananda College',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      color: Color(0xff4E8CDD),
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          debugPrint('Card tapped.');
                        },
                        child: SizedBox(
                          width: 300,
                          // height: 60,
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.amber,
                                    foregroundImage:
                                        AssetImage('assets/images/avatar.png')),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Yasodhya Perera',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Ananda College',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  padding: EdgeInsets.all(12.0),

                  // height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 1,
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 1,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              textStyle: const TextStyle(fontSize: 16)),
                          onPressed: () {},
                          child: Row(
                            children: [
                              Icon(
                                Icons.person_outline_sharp,
                                color: Colors.black,
                                size: 20,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              const Text(
                                'My Profile',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 1,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              textStyle: const TextStyle(fontSize: 16)),
                          onPressed: () {},
                          child: Row(
                            children: [
                              Icon(
                                Icons.settings,
                                color: Colors.black,
                                size: 20,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              const Text(
                                'Settings',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 1,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              textStyle: const TextStyle(fontSize: 16)),
                          onPressed: () {},
                          child: Row(
                            children: [
                              Icon(
                                Icons.help,
                                color: Colors.black,
                                size: 20,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              const Text(
                                'Help',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 1,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              textStyle: const TextStyle(fontSize: 16)),
                          onPressed: () {},
                          child: Row(
                            children: [
                              Icon(
                                Icons.logout_rounded,
                                color: Colors.black,
                                size: 20,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              const Text(
                                'Log out',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          )),
      backgroundColor: Color(0xffE5E5E5),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.indigo[400],
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.white,
        currentIndex: _selected + 1,
        onTap: _ontapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu_book_rounded,
            ),
            label: "Menu",
            backgroundColor: Color(0xff4E8CDD),
          ),
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
