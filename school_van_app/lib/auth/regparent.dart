import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:school_van_app/auth/logindriver.dart';
import 'package:school_van_app/auth/loginparent.dart';
import 'package:school_van_app/screens/parents/parents_home.dart';

import '../services/database.dart';

class regparent extends StatefulWidget {
  final user;
  const regparent({Key? key, required this.user}) : super(key: key);

  @override
  State<regparent> createState() => _regparentState();
}

class _regparentState extends State<regparent> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController school = TextEditingController();
  TextEditingController address = TextEditingController();
  bool obsecure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
          minWidth: MediaQuery.of(context).size.width,
        ),
        child: Container(
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
                      height: 10,
                    ),
                    TextField(
                      controller: firstName,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          contentPadding: EdgeInsets.all(15),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "First Name",
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 15.0)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: lastName,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          contentPadding: EdgeInsets.all(15),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Last Name",
                          hintStyle:
                          TextStyle(color: Colors.grey, fontSize: 15.0)),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    TextField(
                      controller: address,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          contentPadding: EdgeInsets.all(15),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Address",
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 15.0)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: school,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          contentPadding: EdgeInsets.all(15),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "School",
                          hintStyle:
                          TextStyle(color: Colors.grey, fontSize: 15.0)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: ElevatedButton(
                        onPressed: () async {
                          CollectionReference parent = FirebaseFirestore.instance.collection('parent');
                          await parent.doc(widget.user.uid).set(
                              {
                                'uid':widget.user.uid,
                                'type':2,
                                'firstname': firstName.text,
                                'lastname':lastName.text,
                                'Contact_No': widget.user.phoneNumber.toString(),
                                "school":school.text
                              }
                          );
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Parent_Home()));
                        },
                        child: Text('Sign Up'),
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
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => logindriver()));
                            },
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
