import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:school_van_app/loadingscreen.dart';
import 'package:school_van_app/screens/parents/parents_profile.dart';
import 'package:expandable/expandable.dart';

import '../../auth/accountselect.dart';

class ParentProfileMain extends StatefulWidget {
  const ParentProfileMain({Key? key}) : super(key: key);

  @override
  State<ParentProfileMain> createState() => _ParentProfileMainState();
}

class _ParentProfileMainState extends State<ParentProfileMain> {
  FirebaseAuth _auth =FirebaseAuth.instance;
  FirebaseFirestore store =FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CircleAvatar(
                      radius: MediaQuery.of(context).size.height * 0.08,
                      backgroundColor: Colors.amber,
                      foregroundImage: AssetImage('assets/images/avatar.png')),
                ),
                Text(
                  "${_auth.currentUser!.displayName}",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      primary: Color(0xff001B61),
                      textStyle: const TextStyle(fontSize: 16)),
                  onPressed: () {},
                  child: const Text('        Edit Profile      '),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                ),
               Padding(padding: EdgeInsets.all(10),child:  Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text("Children",style: TextStyle(color: Colors.blue[900],fontWeight: FontWeight.bold,fontSize: 20),),
                   IconButton(onPressed:()async{
                     var wait =await showDialog(context: context, builder: (BuildContext context) {
                       TextEditingController name =TextEditingController();
                       TextEditingController school =TextEditingController();
                       TextEditingController email =TextEditingController();
                       String error ="";
                       bool loading =false;
                       return StatefulBuilder(builder: (context,setState){
                         return AlertDialog(
                           title: Text("Add Child"),
                           content:Container(
                               height: MediaQuery.of(context).size.height*0.3,
                               width: MediaQuery.of(context).size.width*0.8,
                               child: (!loading)?ListView(
                                 children: [
                                   Text(error,style: TextStyle(color: Colors.redAccent),),
                                   Container(
                                     child: TextField(
                                       controller: name,
                                       decoration: InputDecoration(
                                           border: OutlineInputBorder(
                                             borderRadius: BorderRadius.circular(15.0),
                                           ),
                                           contentPadding: EdgeInsets.all(15),
                                           filled: true,
                                           fillColor: Colors.white,
                                           hintText: "Child name",
                                           hintStyle:
                                           TextStyle(color: Colors.grey, fontSize: 15.0)),
                                     ),
                                   ),
                                   SizedBox(
                                     height: 10,
                                   ),
                                   Container(
                                     child: TextField(
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
                                   ),
                                   SizedBox(
                                     height: 10,
                                   ),
                                   Container(
                                     child: TextField(
                                       controller: email,
                                       decoration: InputDecoration(
                                           border: OutlineInputBorder(
                                             borderRadius: BorderRadius.circular(15.0),
                                           ),
                                           contentPadding: EdgeInsets.all(15),
                                           filled: true,
                                           fillColor: Colors.white,
                                           hintText: "Driver email",
                                           hintStyle:
                                           TextStyle(color: Colors.grey, fontSize: 15.0)),
                                     ),
                                   ),
                                   SizedBox(
                                     height: 10,
                                   ),
                                 ],
                               ):Container(
                                 height: MediaQuery.of(context).size.width*0.4,
                                 width: MediaQuery.of(context).size.width*0.4,
                                 child: loadfadingcube(),
                               )
                           ),
                           actions: [
                             Container(
                               padding: EdgeInsets.all(10),
                               child: Row(
                                 children: [
                                   Expanded(child: ElevatedButton(onPressed: ()async{
                                     if(email.text.trim().isNotEmpty&&name.text.trim().isNotEmpty&&school.text.trim().isNotEmpty){
                                       setState((){loading=true;});
                                       QuerySnapshot check =await store.collection('driver').where('Email',isEqualTo: email.text.trim()).get();
                                       if(check.docs.isEmpty){
                                         setState((){
                                           error ='Email Not Registered';
                                           setState((){loading=false;});
                                         });
                                       }else{

                                         DocumentSnapshot data =await store.collection('parent').doc(_auth.currentUser!.uid).get();
                                         await store.collection('requests').doc(check.docs[0].id).set({
                                           'requests':[{
                                             'name':name.text.trim(),
                                             'school':name.text.trim(),
                                             'parentid':_auth.currentUser!.uid,
                                             'address':data.get('address')

                                           }]
                                         },SetOptions(merge: true));
                                         setState((){loading=false;});
                                         Navigator.pop(context);
                                       }

                                     }else{
                                       setState((){
                                         error ='Fill all Fields';
                                         setState((){loading=false;});
                                       });
                                     }


                                   }, child: Container(
                                     padding: EdgeInsets.all(20),
                                     child: Text("Submit"),
                                   ),style: ElevatedButton.styleFrom(primary: Colors.blue[900]),))
                                 ],
                               ),
                             )
                           ],
                         );
                       });
                     });

                   },icon: Icon(Icons.add,size: 30,),)
                 ],
               ),),
                FutureBuilder<QuerySnapshot>(future:store.collection("children").where('parentid',isEqualTo:_auth.currentUser!.uid ).get() ,builder: (context,child){
                  List children =[];
                  if(child.connectionState!=ConnectionState.waiting){
                    children = child.data!.docs;
                  }
                  if(children.length>0)
                    {return Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      height: MediaQuery.of(context).size.height*0.4,
                      child: ListView.builder(itemCount: children.length,itemBuilder: (context,index){
                        return Card(
                          child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.5,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.school),
                                            SizedBox(width: 5,),
                                            Text(children[index]['name'])
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.bus_alert),
                                            SizedBox(width: 5,),
                                            Text(children[index]['school'])
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.person),
                                            SizedBox(width: 5,),
                                            Text(children[index]['drivername'])
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  ElevatedButton(onPressed: ()async{
                                    var wait =await store.collection('children').doc(children[index].id).delete();
                                    setState((){});
                                  },child: Text("Remove"),style: ElevatedButton.styleFrom(primary: Colors.red),)
                                ],
                              )
                          ),
                        );
                      }),
                    ),
                  );}else {
                    return Center(
                        child: Text("No Registered children",
                          style: TextStyle(fontSize: 25, color: Colors
                              .blue[900]),)
                    );
                  }

                }),
                SizedBox(
                  height: 20,
                ),
                Container(padding: EdgeInsets.all(12),child: Row(
                  children: [
                    Expanded(child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          padding: EdgeInsets.all(10),
                          textStyle: const TextStyle(fontSize: 16)),
                      onPressed: () async{
                        FirebaseAuth _auth =FirebaseAuth.instance;
                        if(FlutterBackground.isBackgroundExecutionEnabled){
                          await FlutterBackground.disableBackgroundExecution();
                        }
                        _auth.signOut();
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>accountselect()), (route) => false);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.logout_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          const Text(
                            'Log out',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),)
                  ],
                ),)
              ],
            ),
          ),
        ),
    );
  }
}
