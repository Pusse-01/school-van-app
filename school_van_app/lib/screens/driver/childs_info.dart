import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Child_Info extends StatefulWidget {
  const Child_Info({Key? key}) : super(key: key);

  @override
  State<Child_Info> createState() => _Child_InfoState();
}

class _Child_InfoState extends State<Child_Info> {
  FirebaseFirestore store = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  List students = [];
  int? details;
  Map parent = {};
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Students",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900]),
            ),
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.all(10),
            child: StreamBuilder<QuerySnapshot>(
                stream: store
                    .collection('children')
                    .where('driverid', isEqualTo: _auth.currentUser!.uid)
                    .snapshots(),
                builder: (context, snap) {
                  if (snap.connectionState != ConnectionState.waiting &&
                      snap.data?.docs != null) {
                    students = snap.data!.docs;
                  }
                  if (students.isNotEmpty) {
                    return ListView.builder(
                        itemCount: students.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.all(8),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.03),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.person,
                                        size: 30,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                      ),
                                      Text(students[index].get('name'))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.school,
                                        size: 30,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                      ),
                                      Text(students[index].get('school'))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.home,
                                        size: 30,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                      ),
                                      Text(students[index].get('address'))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  (details == index)
                                      ? Container(
                                          child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Parent Details',
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CircleAvatar(
                                                  radius: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.1,
                                                  backgroundImage: (parent
                                                          .containsKey('pic'))
                                                      ? NetworkImage(
                                                          parent['pic'])
                                                      : AssetImage(
                                                              'assets/images/avatar.png')
                                                          as ImageProvider,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  children: [
                                                    (parent.containsKey('name'))
                                                        ? Text(
                                                            parent['name'],
                                                            style: TextStyle(
                                                                fontSize: 18),
                                                          )
                                                        : Text(''),
                                                    (parent.containsKey(
                                                            'Contact_No'))
                                                        ? Text(
                                                            parent[
                                                                'Contact_No'],
                                                            style: TextStyle(
                                                                fontSize: 15),
                                                          )
                                                        : Text('')
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ))
                                      : Container(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(child: SizedBox()),
                                      ElevatedButton(
                                        onPressed: () async {
                                          if (details == null ||
                                              details != index) {
                                            details = index;
                                            DocumentSnapshot parentdetails =
                                                await store
                                                    .collection('parent')
                                                    .doc(students[index]
                                                        .get('parentid'))
                                                    .get();
                                            if (parentdetails.data() != null) {
                                              parent =
                                                  parentdetails.data() as Map;
                                            }
                                          } else {
                                            details = null;
                                          }
                                          setState(() {});
                                        },
                                        child: (details != index)
                                            ? Text('Details')
                                            : Text('Hide'),
                                        style: ElevatedButton.styleFrom(
                                            primary: Color.fromARGB(
                                                255, 166, 167, 168),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15))),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  } else {
                    return Center(
                        child: Text(
                      "No Passengers",
                      style: TextStyle(fontSize: 25, color: Colors.blue[900]),
                    ));
                  }
                }),
          ))
        ],
      ),
    ));
  }
}
