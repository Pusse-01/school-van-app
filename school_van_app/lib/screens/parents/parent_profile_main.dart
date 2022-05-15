import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:school_van_app/screens/parents/parents_profile.dart';
import 'package:expandable/expandable.dart';

class ParentProfileMain extends StatefulWidget {
  const ParentProfileMain({Key? key}) : super(key: key);

  @override
  State<ParentProfileMain> createState() => _ParentProfileMainState();
}

class _ParentProfileMainState extends State<ParentProfileMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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
                "Peter De Almeida",
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
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                // color: Colors.white,
                child: ExpandablePanel(
                    header: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SizedBox(
                              height: 50,
                              width: 50,
                              child:
                                  Image.asset('assets/images/schoolvan.png')),
                        ),
                        Text("School vans"),
                      ],
                    ),
                    collapsed: Text(
                      "",
                    ),
                    expanded: SizedBox(
                      height: 120,
                      child:
                          ListView(scrollDirection: Axis.horizontal, children: [
                        Card(
                          margin: EdgeInsets.all(12),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.person_outlined,
                                            size: 20,
                                            color: Color(0xff4E8CDD),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          AutoSizeText(
                                            "Mr. Nimal",
                                            maxLines: 1,
                                            maxFontSize: 12,
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.bus_alert_rounded,
                                            size: 20,
                                            color: Color(0xff4E8CDD),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          AutoSizeText(
                                            "Nissan Caravan - White",
                                            maxLines: 1,
                                            maxFontSize: 12,
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on_outlined,
                                            size: 20,
                                            color: Color(0xff4E8CDD),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          AutoSizeText(
                                            "Moratuwa to Colombo",
                                            maxLines: 1,
                                            maxFontSize: 12,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                        Card(
                          margin: EdgeInsets.all(12),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Center(
                                child: Row(
                              children: [
                                Icon(
                                  Icons.add,
                                  size: 15,
                                  color: Colors.grey,
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child: AutoSizeText(
                                      "Add driver",
                                      maxLines: 1,
                                      maxFontSize: 12,
                                      style: TextStyle(color: Colors.grey),
                                    ))
                              ],
                            )),
                          ),
                        )
                      ]),
                    )
                    // tapHeaderToExpand: true,
                    // hasIcon: true,
                    ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                // color: Colors.white,
                child: ExpandablePanel(
                    header: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SizedBox(
                              height: 50,
                              width: 50,
                              child: Image.asset('assets/images/students.png')),
                        ),
                        Text("Children"),
                      ],
                    ),
                    collapsed: Text(
                      "",
                    ),
                    expanded: SizedBox(
                      height: 100,
                      child:
                          ListView(scrollDirection: Axis.horizontal, children: [
                        Card(
                          margin: EdgeInsets.all(12),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.person_outlined,
                                            size: 20,
                                            color: Color(0xff4E8CDD),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          AutoSizeText(
                                            "Ryan",
                                            maxLines: 1,
                                            maxFontSize: 12,
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.bus_alert_rounded,
                                            size: 20,
                                            color: Color(0xff4E8CDD),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          AutoSizeText(
                                            "Kingswood College",
                                            maxLines: 1,
                                            maxFontSize: 12,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                        Card(
                          margin: EdgeInsets.all(12),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.person_outlined,
                                            size: 20,
                                            color: Color(0xff4E8CDD),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          AutoSizeText(
                                            "Ryan",
                                            maxLines: 1,
                                            maxFontSize: 12,
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.bus_alert_rounded,
                                            size: 20,
                                            color: Color(0xff4E8CDD),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          AutoSizeText(
                                            "Kingswood College",
                                            maxLines: 1,
                                            maxFontSize: 12,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                        Card(
                          margin: EdgeInsets.all(12),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Center(
                                child: Row(
                              children: [
                                Icon(
                                  Icons.add,
                                  size: 15,
                                  color: Colors.grey,
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child: AutoSizeText(
                                      "Add Child",
                                      maxLines: 1,
                                      maxFontSize: 12,
                                      style: TextStyle(color: Colors.grey),
                                    ))
                              ],
                            )),
                          ),
                        )
                      ]),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          textStyle: const TextStyle(fontSize: 16)),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Icon(
                            Icons.settings,
                            color: Colors.black,
                            size: 20,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          const Text(
                            'Settings',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          textStyle: const TextStyle(fontSize: 16)),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Icon(
                            Icons.help,
                            color: Colors.black,
                            size: 20,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          const Text(
                            'Help',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          textStyle: const TextStyle(fontSize: 16)),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout_rounded,
                            color: Colors.black,
                            size: 20,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          const Text(
                            'Log out',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
