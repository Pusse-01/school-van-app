import 'package:flutter/material.dart';
import 'package:school_van_app/auth/regdriver.dart';
import 'package:school_van_app/auth/regparent.dart';

class accountselect extends StatelessWidget {
  const accountselect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: Container(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(30),bottomLeft: Radius.circular(30)),
                    color: Colors.indigo[800]

                  ),

                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>regdriver()));
                    },
                        child:Container(
                          height: MediaQuery.of(context).size.height*0.2,
                          width: MediaQuery.of(context).size.width*0.4,
                          color: Colors.redAccent[300],
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.redAccent[200],
                                  image: DecorationImage(image:AssetImage(
                                      'assets/Schoolbus.png'
                                  ),fit: BoxFit.contain )
                                ),
                                padding: EdgeInsets.all(10),
                                height: MediaQuery.of(context).size.width*0.2,
                                width: MediaQuery.of(context).size.width*0.2,
                              ),
                              SizedBox(height: 10,),
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('I am a Driver ',style: TextStyle(color: Colors.black),),
                                    Icon(Icons.arrow_forward,size: 20,color: Colors.black)

                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.redAccent[100],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                      ),
                    ),
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>regparent()));
                    },
                      child:Container(
                        height: MediaQuery.of(context).size.height*0.2,
                        width: MediaQuery.of(context).size.width*0.4,
                        color: Colors.blueAccent[300],
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blueAccent[200],
                                  image: DecorationImage(image:AssetImage(
                                      'assets/Family.png'
                                  ),fit: BoxFit.contain )
                              ),
                              padding: EdgeInsets.all(10),
                              height: MediaQuery.of(context).size.width*0.2,
                              width: MediaQuery.of(context).size.width*0.2,
                            ),
                            SizedBox(height: 10,),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('I am a Parent ',style: TextStyle(color: Colors.black),),
                                  Icon(Icons.arrow_forward,size: 20,color: Colors.black,)

                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.blueAccent[100],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
