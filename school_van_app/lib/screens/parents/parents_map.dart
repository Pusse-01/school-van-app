import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:ui' as ui;

class Parents_map extends StatefulWidget {
  final markerdriver,markeruser;
  const Parents_map({Key? key,this.markerdriver,this.markeruser}) : super(key: key);

  @override
  State<Parents_map> createState() => _Parents_mapState();
}

class _Parents_mapState extends State<Parents_map> {

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore store = FirebaseFirestore.instance;
  LocationSettings locationSettings = LocationSettings(accuracy: LocationAccuracy.best, distanceFilter: 1);
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
  bool started = false;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    locationservice();


  }
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    locationservice();
  }
  @override
  Widget build(BuildContext context) {
      return SafeArea(
          child:Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.height,
            child: SafeArea(
              child: Container(
                padding: EdgeInsets.only(top: 16),
                child: Column(
                  children: [
                    Row(
                      children: [

                        Expanded(child:Container(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            "Map",
                            style: TextStyle(
                                fontSize: 25.0,
                                color: Colors.indigo[900],
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                      ],
                    ),
                    Container(
                        child: Expanded(
                          child: GoogleMap(
                            initialCameraPosition:
                            CameraPosition(target: initital!, zoom: 16),
                            onMapCreated: (GoogleMapController ctrl) {
                              control = ctrl;

                            },
                            markers: marks,
                            polylines: Set<Polyline>.of(polylines.values),
                          ),
                        )),
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
           icon: BitmapDescriptor.fromBytes(widget.markeruser!),
           position: LatLng(current!.latitude, current!.longitude),

       ),
     );
   });
    control?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(current!.latitude, current!.longitude), zoom: 16)));
    Geolocator.getPositionStream(locationSettings: locationSettings).distinct()
        .listen((event) async {
      setState(() {
        current = event;
        initital = LatLng(event.latitude, event.longitude);
        for(var i in marks){

          if(i.markerId==MarkerId('My location')){
            marks.remove(i);
            break;
          }
        }
        marks.add(
          Marker(
              markerId: MarkerId('My location'),
              icon: BitmapDescriptor.fromBytes(widget.markeruser!),
              position: LatLng(current!.latitude, current!.longitude),
              infoWindow: InfoWindow(
                title: 'Your Location',
                snippet: '20 min',

              )

          ),
        );
        control?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(initital!.latitude, initital!.longitude), zoom: 16)));
      });
    });
  }
}
