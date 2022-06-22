import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:school_van_app/auth/parentOtpController.dart';
import 'package:school_van_app/loadingscreen.dart';

import '../locationservice/mapservice.dart';
import '../services/authentication.dart';
import '../wrappers/parentlocationwrapper.dart';

class ParentVerify extends StatefulWidget {
  final String phone;
  final String countryCode;
  const ParentVerify({Key? key,required this.phone, required this.countryCode}) : super(key: key);

  @override
  State<ParentVerify> createState() => _parentVeridyState();
}

class _parentVeridyState extends State<ParentVerify> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _pinOTPController = TextEditingController();
  final FocusNode _pinOTPFocusNode = FocusNode();

  String? verificationCode;

  final BoxDecoration pinOTPDecoration = BoxDecoration(
      color: Colors.blueAccent,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: Colors.grey,

      )
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verifyPhone();
  }

  verifyPhone() async{
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber:  "${widget.countryCode+widget.phone}",
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential).then((value){
            if(value.user!= null){
              // Navigator.of(context).push(MaterialPageRoute(builder: (c)=>Parent_Dashboard()));
            }
          });
        },
        verificationFailed: (FirebaseAuthException e){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.message.toString() ),duration: Duration(seconds: 3),),
          );
        },
        codeSent: (String vID, int?  resentToken){
          setState(() {
            verificationCode = vID;
          });
        },
        codeAutoRetrievalTimeout: (String vID){
          setState(() {
            verificationCode = vID;
          });
        },
        timeout: Duration(seconds: 60)
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                    GestureDetector(
                      onTap: (){

                      },
                      child: Text(
                        'Verifying : ${widget.countryCode} - ${widget.phone}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(40),
                        child: PinPut(
                          fieldsCount: 6,
                          textStyle: TextStyle(fontSize: 25,color: Colors.white),
                          eachFieldHeight: 55.0,
                          eachFieldWidth: 40,
                          focusNode: _pinOTPFocusNode,
                          controller: _pinOTPController,
                          submittedFieldDecoration: pinOTPDecoration,
                          selectedFieldDecoration: pinOTPDecoration,
                          followingFieldDecoration: pinOTPDecoration,
                          pinAnimationType: PinAnimationType.rotation,
                          onSubmit: (pin) async{
                            try{
                              await FirebaseAuth.instance
                                  .signInWithCredential(PhoneAuthProvider
                                  .credential(verificationId: verificationCode! , smsCode: pin))
                                  .then((value) async {
                                if(value.user!= null){
                                  FirebaseFirestore store = FirebaseFirestore
                                      .instance;
                                  DocumentSnapshot details = await store.collection(
                                      'parent').doc(value.user!.uid).get();
                                  Map data =details.data() as Map;
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            parentwrapper(data:data ,)
                                    ),
                                        (route) => false,
                                  );
                                }
                              });
                            }catch(e){
                              FocusScope.of(context).unfocus();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Invalid OTP"),duration: Duration(seconds: 3),),
                              );
                            }
                          },
                        )
                    )
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