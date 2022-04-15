
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:school_van_app/loadingscreen.dart';
import 'package:school_van_app/models/location.dart';



class locationfind extends StatefulWidget {
  const locationfind({Key? key}) : super(key: key);

  @override
  _locationfindState createState() => _locationfindState();
}

class _locationfindState extends State<locationfind> {
  Location location = Location();
  LocationData ? current;
  String ?error;
  LatLng ?initital = LatLng(0, 0);
  FirebaseAuth _auth =FirebaseAuth.instance;
  FirebaseFirestore store =FirebaseFirestore.instance;
  GoogleMapController ? control;
  bool loading=false;

  PolylinePoints polylinePoints = PolylinePoints();
  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};
  Set <Marker>marks={};
  bool started=false;
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
    locationservice();
    getdata();

  }

  @override
  Widget build(BuildContext context) {
       return Scaffold(

           body: ConstrainedBox(
             constraints: BoxConstraints(
               minHeight: MediaQuery.of(context).size.height,
               minWidth: MediaQuery.of(context).size.width,
             ),
             child: SafeArea(child:Container(
                 padding: EdgeInsets.all(10.0),
                 child:  SingleChildScrollView(
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

                         height: MediaQuery.of(context).size.height*0.65,
                         child: GoogleMap(
                           initialCameraPosition: CameraPosition(target: initital!, zoom: 20),
                           onMapCreated: (GoogleMapController ctrl) {
                             control = ctrl;

                           },
                           markers: marks,
                           polylines: Set<Polyline>.of(polylines.values),
                           myLocationEnabled: true,
                         ),
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
                                       borderRadius: BorderRadius.circular(25)
                                   )
                               ),
                             ),
                           )
                         ],
                       )
                     ],
                   ),
                 )
             )),
           )
       );
     }

  Future locationservice() async {
    bool serviceen = await location.serviceEnabled();
    if (!serviceen) {
      bool reqserviceres = await location.requestService();
      if (!reqserviceres) {
        setState(() {
          error = "Service Not Enabled";
          return;
        });
      }
    }

    PermissionStatus permission = await location.hasPermission();
    if (!serviceen) {
      PermissionStatus reqserviceres = await location.requestPermission();
      if (reqserviceres == PermissionStatus.denied) {
        setState(() {
          error = "Permission Not Granted";
          return;
        });
      }
    }
    location.changeSettings(
        accuracy: LocationAccuracy.high, interval: 1000, distanceFilter: 1);
    current = await location.getLocation();
    location.onLocationChanged.distinct().listen((event) async {
      ///////////////////////////////////////////////////////////

      ///////////////////////////////////////////////////////////
      setState(() {
        current = event;
        initital = LatLng(event.latitude!, event.longitude!);
        control?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(event.latitude!, event.longitude!), zoom: 20)));
      });
      if (started) {
        await store.collection('location').doc(_auth.currentUser!.uid).update({
          'corrds': {'long': event.longitude, 'lat': event.latitude}
        });
      }
    }


    );
  }
}
