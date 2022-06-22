import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:school_van_app/auth/parentNumberVerify.dart';
import 'package:school_van_app/auth/regparent.dart';
import 'package:school_van_app/loadingscreen.dart';
import 'package:school_van_app/screens/driver/driverhome.dart';
import 'package:school_van_app/screens/parents/parents_home.dart';
import 'package:school_van_app/wrappers/authwrapper.dart';
import 'package:school_van_app/wrappers/parentlocationwrapper.dart';

import '../locationservice/mapservice.dart';
import '../services/authentication.dart';

class parentlogin extends StatefulWidget {
  const parentlogin({Key? key}) : super(key: key);

  @override
  State<parentlogin> createState() => _parentloginState();
}

class _parentloginState extends State<parentlogin> {
  TextEditingController phoneNumber = TextEditingController();
  bool obsecure = true;
  String error = "";
  bool loading = false;
  String countryCode = "";
  Map data={};
  @override
  Widget build(BuildContext context) {
    if (loading) {
      return loadfadingcube();
    } else {
      return Scaffold(
        body: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
            minWidth: MediaQuery.of(context).size.width,
          ),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Text(
                              'Parent',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          height: MediaQuery.of(context).size.height * 0.25,
                          child: Image(
                            image: AssetImage('assets/images/parent_auth.png'),
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      Text(error,style: TextStyle(color: Colors.redAccent),),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 400,
                        height: 60,
                        child:  CountryCodePicker(
                          onChanged: (country)=>{
                            setState((){
                              countryCode = country.dialCode!;
                            })
                          },
                          initialSelection: "LK",
                          showCountryOnly: false,
                          showOnlyCountryWhenClosed: false,
                          favorite: ["+94","LK"],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      TextField(
                          controller: phoneNumber,
                          maxLength: 9,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefix: Padding(
                              padding: EdgeInsets.all(4),
                              child: Text(countryCode),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            contentPadding: EdgeInsets.all(15),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Phone Number",
                            hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 15.0),
                          )),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: ElevatedButton(
                          onPressed: () async {
                            if(phoneNumber.text.trim()!=""&&countryCode!=""){
                              Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (c) =>
                                        ParentVerify(
                                          phone:phoneNumber.text,
                                          countryCode: countryCode ,
                                        ),
                                  )
                              );
                            }else{
                              setState(() {
                                error = "Fill all fields";
                              });
                            }
                          },
                          child: Text('Log in'),
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(16),
                              primary: Colors.indigo[900],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25))),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account",
                            style: TextStyle(fontSize: 18),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>regparent()));
                              },
                              child: Text(
                                "Sign up",
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 18),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}
