
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:ui' as ui;
import 'package:flutter_background_service_android/flutter_background_service_android.dart';








class locationfind extends StatefulWidget {
  const locationfind({Key? key}) : super(key: key);

  @override
  _locationfindState createState() => _locationfindState();
}

class _locationfindState extends State<locationfind> {
  FirebaseAuth _auth =FirebaseAuth.instance;
  FirebaseFirestore store =FirebaseFirestore.instance;
  LocationSettings locationSettings =LocationSettings(
      accuracy: LocationAccuracy.best,distanceFilter: 1
  );
  BitmapDescriptor ? customIcon;
  Position ? current;
  String ?error;
  LatLng ?initital = LatLng(0, 0);
  GoogleMapController ? control;
  bool loading=false;

  PolylinePoints polylinePoints = PolylinePoints();
  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};
  Set <Marker>marks={};
  Uint8List? markerIcon;
  bool started=false;




  void getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    markerIcon= (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void getdata()async{
    DocumentSnapshot snapshot=await store.collection('location').doc(_auth.currentUser!.uid).get();
    if(snapshot.data()!=null){
      started = snapshot.get('status');

    }

  }


  void initState() {

    // TODO: implement initState
    super.initState();
    getBytesFromAsset('assets/mapbus.png', 150);
    locationservice();
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
                      Text("Map",style: TextStyle(fontSize: 25.0,color:Colors.indigo[900],fontWeight: FontWeight.bold),),
                      Expanded(child:SizedBox()),
                      TextButton(onPressed: ()async{
                        FirebaseAuth _auth =FirebaseAuth.instance;
                        await  _auth.signOut();
                        setState(() { });
                      }, child: Text('Sign Out'))
                    ],
                  ),
                  Container(


                      child:Expanded(
                        child:  GoogleMap(
                          initialCameraPosition: CameraPosition(target: initital!, zoom: 10),
                          onMapCreated: (GoogleMapController ctrl) {
                            control = ctrl;

                          },
                          markers: marks,
                          polylines: Set<Polyline>.of(polylines.values),

                        ),
                      )
                  ),
                  SizedBox(height: 20.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*0.9,
                        child: ElevatedButton(
                          onPressed:()async{


                            if(!started){

                              await store.collection('location').doc(_auth.currentUser!.uid).set(
                                  {
                                    'status':true,
                                    'corrds':{}

                                  }
                              );
                            }else{


                              await store.collection('location').doc(_auth.currentUser!.uid).update(
                                  {
                                    'status':false,
                                  }
                              );
                            }
                            setState(() {
                              started=!started;
                            });
                          },
                          child: (started)?Text('End Trip'):Text('Start Trip'),
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(16),
                              primary: Colors.indigo[900],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)
                              )
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        )
    );
  }

  Future locationservice() async {
    bool serviceen = await Geolocator.isLocationServiceEnabled();
    if (serviceen) {
      LocationPermission check =await Geolocator.checkPermission();
      var get =await Geolocator.requestPermission();
      if (check==LocationPermission.denied) {
        setState(() {
          error = "Service Not Enabled";
          return;
        });
      }
    }
    

    current = await Geolocator.getCurrentPosition();
    Geolocator.getPositionStream(locationSettings: locationSettings).distinct().listen((event) async {
      ///////////////////////////////////////////////////////////

      ///////////////////////////////////////////////////////////
      setState(() {
        current = event;
        initital = LatLng(event.latitude, event.longitude);
        marks.clear();
        marks.add(Marker(markerId:MarkerId('current'),icon: BitmapDescriptor.fromBytes(markerIcon!),position: LatLng(current!.latitude,current!.longitude) ),);
        control?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(event.latitude, event.longitude), zoom: 20)));
      });
      if(started){
        await store.collection('location').doc(_auth.currentUser!.uid).update({
          'corrds': {'long': event.longitude, 'lat': event.latitude}


        }


        );
      }

    }


    );
  }
}