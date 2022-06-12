
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:school_van_app/screens/parents/parent_profile_main.dart';
import 'package:school_van_app/screens/parents/parents_dashboard.dart';
import 'package:school_van_app/screens/parents/parents_map.dart';
import 'dart:ui' as ui;
import 'package:school_van_app/screens/parents/parents_profile.dart';


import '../../auth/accountselect.dart';
import '../../services/notifications.dart';

class Parent_Home extends StatefulWidget {
  const Parent_Home({Key? key}) : super(key: key);

  @override
  State<Parent_Home> createState() => _Parent_HomeState();
}

class _Parent_HomeState extends State<Parent_Home> {
  int _selected = 0;
  bool started = false;
  String? kidid;
  List driverids=[];
  bool notified=false;


  Uint8List? markerIcondriver;
  Uint8List? markerIconuser;
  List childdata=[];
  List driverdata =[];
  FirebaseAuth _auth =FirebaseAuth.instance;
  FirebaseFirestore store =FirebaseFirestore.instance;


  String? selected;


  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  void _ontapped(int index) {
    index == 0
        ? _drawerKey.currentState?.openDrawer()
        : setState(() {
      _selected = index;
      print(_selected);

    });
  }

  void snapshotstream()async{
    store.collection('children').where('parentid',isEqualTo: _auth.currentUser!.uid).snapshots().listen((event) {
      event.docChanges.forEach((element) async{
        if(element.doc.get('started')){
          if(element.doc.get('dropped')){
            NotificationService.shownotification(title: '${element.doc.get('drivername')}',body:'Child safely arrived at destination',payload: 'drop notification' );
          }else if(element.doc.get('t2remainder')){
            NotificationService.shownotification(title: '${element.doc.get('drivername')}',body:'Child picked up from the school',payload: 'pick up  notification' );
          }else if(element.doc.get('atschool')){
            NotificationService.shownotification(title: '${element.doc.get('drivername')}',body:'Child safely arrived at school',payload: 'drop notification' );
          }else if(element.doc.get('picked_up')){
            NotificationService.shownotification(title: '${element.doc.get('drivername')}',body:'Child picked up from the house',payload: 'drop notification' );
          }else if(element.doc.get('notifed')){
            NotificationService.shownotification(title: '${element.doc.get('drivername')}',body:'I\'m Arrivaing soon',payload: 'drop notification' );
            print('start');
          }
        }
      });
    });
  }

  void backgroundservice()async{
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

  }

  getBytesFromAssetfordriver(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    markerIcondriver = (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
  getBytesFromAssetforuser(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    markerIconuser =
        (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
            .buffer
            .asUint8List();
  }
void changeselected(driverid,childid){
  selected =driverid;
  kidid =childid;
}

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    backgroundservice();
    snapshotstream();
    getBytesFromAssetfordriver('assets/images/mapbus.png', 75);
    getBytesFromAssetforuser('assets/images/user_location.png', 75);
    NotificationService.init();

  }
  void change(){
    notified=!notified;
  }
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    snapshotstream();
  }


  @override
  Widget build(BuildContext context) {

    List<Widget> _widgetOptions = <Widget>[
      Parent_Dashboard(selected: selected,kidid: kidid,ontapped: _ontapped),
      Parent_Dashboard(selected: selected,kidid: kidid,ontapped: _ontapped),
      Parents_map(markerdriver: markerIcondriver,markeruser: markerIconuser,driverids: driverids,notified: notified,change: change,),
      ParentProfileMain()
    ];
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      key: _drawerKey,
      drawer: Drawer(
          backgroundColor: Color(0xfff1f3fa),
          child: Column(
            // padding: EdgeInsets.zero,
            children: [
              Expanded(child: Container(
                width: MediaQuery.of(context).size.width,
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
                        '  ${_auth.currentUser!.displayName}',
                        maxFontSize: 16,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ),),
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
                   Container(
                     height: MediaQuery.of(context).size.height*0.3,
                     child:  StreamBuilder<QuerySnapshot>(stream :store.collection('children').where('parentid',isEqualTo: _auth.currentUser!.uid).snapshots(), builder: (context,snap){
                       if(snap.connectionState!=ConnectionState.waiting){
                         childdata =snap.data!.docs as List;
                         driverids=[];
                         childdata.forEach((element) {
                           driverids.add(element['driverid']);
                           selected =element['driverid'];
                           kidid =element.id;
                         });

                       }
                       return  ListView.builder(
                         itemCount: childdata.length,
                         itemBuilder: (BuildContext context, int index) {

                           return Card(
                             color: Color(0xff4E8CDD),
                             child: InkWell(
                               splashColor: Colors.blue.withAlpha(30),
                               onTap: () {
                                  setState((){
                                    selected =childdata[index]['driverid'];
                                    kidid =childdata[index].id;

                                  });
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
                                             '${childdata[index]['name']}',
                                             style: TextStyle(
                                                 color: Colors.white,
                                                 fontWeight: FontWeight.bold),
                                           ),
                                           SizedBox(
                                             height: 5,
                                           ),
                                           Text(
                                             '${childdata[index]['school']}',
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
                           ) ;
                         },
                       );

                     })
                   ),

                  ],
                ),
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
                          onPressed: () {
                            _ontapped(3);
                          },
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
                          onPressed: () async{
                            _auth.signOut();
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>accountselect()), (route) => false);
                            await FlutterBackground.disableBackgroundExecution();
                            setState(() {});
                          },
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

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.indigo[400],
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.white,
        currentIndex: _selected,
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
        child: (selected!=null||_selected==2||_selected==3)?_widgetOptions.elementAt(_selected):Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SafeArea(child:Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.5,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue[900],
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(50),bottomLeft: Radius.circular(50)),
                  image: DecorationImage(image: AssetImage('assets/images/schoolvan.png'),
                    fit: BoxFit.contain,
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.all(10),
                    child: Text(
                      'Select Child',
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'Cherry Cream Soda',
                        color: Color.fromARGB(255, 245, 246, 247),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                )
              ),
              FutureBuilder<QuerySnapshot>(future:store.collection('children').where('parentid',isEqualTo: _auth.currentUser!.uid).get() ,builder: (context,data){
                bool childhave =false;
                if(data.connectionState!=ConnectionState.waiting){
                  if(data.data!.docs.isNotEmpty){
                    childhave =true;

                  }
                }
                return Expanded(child: Center(
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: (childhave)?Text("Welcome ${_auth.currentUser!.displayName} !!! \nSelect Child from Menu to continue.....",style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'Cherry Cream Soda',
                        color: Colors.blue[900],
                        fontWeight: FontWeight.w700,
                      ),):Text("Welcome ${_auth.currentUser!.displayName} !!! \nAdd a child in Profile section.....",style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'Cherry Cream Soda',
                        color: Colors.blue[900],
                        fontWeight: FontWeight.w700,
                      ),)
                  ),
                ),);

              })
            ],
          ),),
        ),
      ),
    );
  }
}
