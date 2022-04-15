
import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';

class vanlocate extends ChangeNotifier{
  static final vanlocate _singleton = vanlocate._internal();

  factory vanlocate() {
    return _singleton;
  }

  vanlocate._internal();
  Location location=Location();
  LocationData ? current;

  Future locationservice() async {

    location.changeSettings(
        accuracy: LocationAccuracy.high, interval: 4000, distanceFilter: 5);
    current = await location.getLocation();
    location.onLocationChanged.distinct().listen((event){
      current=event;
      print(current);
      notifyListeners();
    });


  }

}