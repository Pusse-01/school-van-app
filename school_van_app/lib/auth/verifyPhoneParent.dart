import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:school_van_app/auth/otpController.dart';
import 'package:school_van_app/loadingscreen.dart';

import '../locationservice/mapservice.dart';
import '../services/authentication.dart';

class ParentVerify extends StatefulWidget {
  const ParentVerify({Key? key}) : super(key: key);

  @override
  State<ParentVerify> createState() => _parentVeridyState();
}

class _parentVeridyState extends State<ParentVerify> {
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController password = TextEditingController();
  String countryCode = "";
  bool obsecure = true;
  String error = "";
  bool loading = false;
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
                      TextField(
                          controller: phoneNumber,
                          maxLength: 12,
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
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: ElevatedButton(
                          onPressed: () async {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (c) =>
                                    OTPControllerScreen(
                                      phone:phoneNumber.text,
                                      countryCode: countryCode ,
                                    ),
                              )
                            );
                          },
                          child: Text('Next'),
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
                            "Already have an account",
                            style: TextStyle(fontSize: 18),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                "Log In",
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
