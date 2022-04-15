import 'package:flutter/material.dart';
import 'package:school_van_app/auth/logindriver.dart';
import 'package:school_van_app/auth/loginparent.dart';


class regparent extends StatefulWidget {
  const regparent({Key? key}) : super(key: key);

  @override
  State<regparent> createState() => _regparentState();
}

class _regparentState extends State<regparent> {
  TextEditingController name =TextEditingController();
  TextEditingController email =TextEditingController();
  TextEditingController contact =TextEditingController();
  TextEditingController password =TextEditingController();
  TextEditingController confirm =TextEditingController();
  TextEditingController driving =TextEditingController();
  TextEditingController NIC =TextEditingController();
  TextEditingController address =TextEditingController();
  bool obsecure =true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery
              .of(context)
              .size
              .height,
          minWidth: MediaQuery
              .of(context)
              .size
              .width,
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
                          Text('Parent', style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.25,
                        child: Image(
                          image: AssetImage(
                              'assets/Family.png'
                          ),
                        )
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      controller: name,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),

                          ),
                          contentPadding: EdgeInsets.all(15),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Name",
                          hintStyle:
                          TextStyle(color: Colors.grey, fontSize: 15.0)
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      controller: email,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          contentPadding: EdgeInsets.all(15),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Email",
                          hintStyle:
                          TextStyle(color: Colors.grey, fontSize: 15.0)
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      controller: contact,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          contentPadding: EdgeInsets.all(15),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Contact number",
                          hintStyle:
                          TextStyle(color: Colors.grey, fontSize: 15.0)
                      ),
                    ),
                    SizedBox(height: 10,),
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
                          TextStyle(color: Colors.grey, fontSize: 15.0)
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextField(
                        controller: password,
                        obscureText: obsecure,
                        decoration: InputDecoration(
                            border:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            contentPadding: EdgeInsets.all(15),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Password",
                            hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 15.0),
                            suffix: InkWell(
                              onTap: () {
                                setState(() {
                                  obsecure = !obsecure;
                                });
                              },
                              child: Icon((obsecure)
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,size: 20,),
                            ))
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      controller: confirm,
                        obscureText: obsecure,
                        decoration: InputDecoration(
                            border:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            contentPadding: EdgeInsets.all(15),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Confirm Password",
                            hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 15.0),
                            suffix: InkWell(
                              onTap: () {
                                setState(() {
                                  obsecure = !obsecure;
                                });
                              },
                              child: Icon((obsecure)
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,size: 20,),
                            ))
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.7,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('Sign Up'),
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(16),
                            primary: Colors.indigo[900],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)
                            )
                        ),
                      ),
                    ),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account", style: TextStyle(
                            fontSize: 18),),
                        TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>logindriver()));
                            },
                            child: Text(
                              "Log In",
                              style: TextStyle(
                                  color: Colors.blue, fontSize: 18),
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

