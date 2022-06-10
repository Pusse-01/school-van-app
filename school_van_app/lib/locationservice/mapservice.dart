import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:ui' as ui;
import 'package:school_van_app/auth/accountselect.dart';

class locationfind extends StatefulWidget {
  const locationfind({Key? key}) : super(key: key);

  @override
  _locationfindState createState() => _locationfindState();
}

class _locationfindState extends State<locationfind> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore store = FirebaseFirestore.instance;
  LocationSettings locationSettings =
      LocationSettings(accuracy: LocationAccuracy.best, distanceFilter: 1);
  BitmapDescriptor? customIcon;
  Position? current;
  String? error;
  LatLng? initital = LatLng(0, 0);
  GoogleMapController? control;
  bool loading = false;

  PolylinePoints polylinePoints = PolylinePoints();
  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};
  Set<Marker> marks = {};
  Uint8List? markerIcon,markerIconuser;
  bool started = false;

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

  void getlocations ()async{
    QuerySnapshot data =await store.collection('children').where('driverid',isEqualTo: _auth.currentUser!.uid).get();
    List students = data.docs;
    students.forEach((element) async{
     DocumentSnapshot d =await store.collection('parent').doc(element.get('parentid')).get();
     marks.add(Marker(
         markerId: MarkerId('${d.get('name')}'),
         icon: BitmapDescriptor.fromBytes(markerIconuser!),
         position: LatLng(d.get('location')['lat'], d.get('location')['lon']),
         infoWindow: InfoWindow(
           title: d.get('name'),

         )

     ),);
    });
  }

  void getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    markerIcon = (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
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

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void getdata() async {
    DocumentSnapshot snapshot =
        await store.collection('location').doc(_auth.currentUser!.uid).get();
    if (snapshot.data() != null) {
      started = snapshot.get('status');
    }
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    getBytesFromAsset('assets/images/mapbus.png', 75);
    getBytesFromAssetforuser('assets/images/user_location.png', 75);
    locationservice();
    getlocations();
    getdata();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.height,
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Map",
                    style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.indigo[900],
                        fontWeight: FontWeight.bold),
                  ),
                  Expanded(child: SizedBox()),

                ],
              ),
              Container(
                  child: Expanded(
                child: GoogleMap(
                  initialCameraPosition:
                      CameraPosition(target: initital!, zoom: 10),
                  onMapCreated: (GoogleMapController ctrl) {
                    control = ctrl;
                  },
                  markers: marks,
                  polylines: Set<Polyline>.of(polylines.values),
                ),
              )),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (!started) {
                          backgroundservice();
                          await store
                              .collection('location')
                              .doc(_auth.currentUser!.uid)
                              .set({'status': true, 'corrds': {},'speed':current!.speed,'name':_auth.currentUser!.displayName});
                        } else {
                          await FlutterBackground.disableBackgroundExecution();
                          QuerySnapshot data =await store.collection('children').where('driverid',isEqualTo: _auth.currentUser!.uid).get();
                          List students = data.docs;
                          students.forEach((element) async{
                            await store.collection('children').doc(element.id).update(
                                {
                                  'notifications':{},
                                  'dropped':false,
                                  'picked_up':false,

                                });
                          });
                          await store
                              .collection('location')
                              .doc(_auth.currentUser!.uid)
                              .update({
                            'status': false,
                          });
                        }
                        setState(() {
                          started = !started;
                        });
                      },
                      child: (started) ? Text('End Trip') : Text('Start Trip'),
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(16),
                          primary: Colors.indigo[900],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }

  Future locationservice() async {
    bool serviceen = await Geolocator.isLocationServiceEnabled();
    if (serviceen) {
      LocationPermission check = await Geolocator.checkPermission();
      var get = await Geolocator.requestPermission();
      if (check == LocationPermission.denied) {
        setState(() {
          error = "Service Not Enabled";
          return;
        });
      }
    }

    current = await Geolocator.getCurrentPosition();
    setState(() {
      marks.add(
        Marker(
            markerId: MarkerId('My location'),
            icon: BitmapDescriptor.fromBytes(markerIcon!),
            position: LatLng(current!.latitude, current!.longitude),
            infoWindow: InfoWindow(
              title: 'Your Location',

            )

        ),
      );
    });
   if(mounted){
     control?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
         target: LatLng(current!.latitude, current!.longitude), zoom: 16)));
   }
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .distinct()
        .listen((event) async {
      ///////////////////////////////////////////////////////////

      ///////////////////////////////////////////////////////////
      setState(() {
        current = event;
        initital = LatLng(event.latitude, event.longitude);
        for(var i in marks){

          if(i.markerId==MarkerId('My location')){
            print(i.markerId);
            marks.remove(i);
            break;
          }
        }
        marks.add(
          Marker(
              markerId: MarkerId('My location'),
              icon: BitmapDescriptor.fromBytes(markerIcon!),
              position: LatLng(current!.latitude, current!.longitude)),
        );
       if(mounted){
         control?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
             target: LatLng(event.latitude, event.longitude), zoom: 16)));
       }
      });
      if (started) {
        await store.collection('location').doc(_auth.currentUser!.uid).update({
          'corrds': {'long': event.longitude, 'lat': event.latitude},
          'speed':current!.speed
        });
      }
    });
  }
}
