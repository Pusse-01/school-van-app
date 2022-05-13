import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
// import 'package:timelines/timelines.dart';

class Parent_Dashboard extends StatefulWidget {
  const Parent_Dashboard({Key? key}) : super(key: key);

  @override
  State<Parent_Dashboard> createState() => _Parent_DashboardState();
}

class _Parent_DashboardState extends State<Parent_Dashboard> {
  bool isReminder1 = true;
  bool isPickedup = true;
  bool isAtSchool = true;
  bool isReminder2 = true;
  bool isDroped = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                  child: Text(
                    "Hi Peter...",
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.40,
                  decoration: const BoxDecoration(
                    color: Color(0xff4E8CDD),
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(children: const [
                          Text(
                            "Trip 1",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )
                        ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Start",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "06:30 AM",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              )
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "End",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "07:30 AM",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              )
                            ])
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.40,
                  decoration: const BoxDecoration(
                    color: Color(0xff4E8CDD),
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(children: const [
                          Text(
                            "Trip 2",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )
                        ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Start",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "12:30 PM",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              )
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "End",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "14:30 PM",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              )
                            ])
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        primary: Color(0xff001B61),
                        textStyle: const TextStyle(fontSize: 16)),
                    onPressed: () {},
                    child: const Text('Start tracking the location'),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 8.0, 12.0, 0.0),
                  child: Text(
                    "Driver",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
              height: MediaQuery.of(context).size.height * 0.28,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          "Mr. Perera",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.document_scanner),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          "B4628933",
                          style: TextStyle(
                            fontSize: 16.0,
                            // fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.drive_eta),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          "CE 2349",
                          style: TextStyle(
                            fontSize: 16.0,
                            // fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.phone_android),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          "070 4575691",
                          style: TextStyle(
                            fontSize: 16.0,
                            // fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.bus_alert),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          "20 Seats available",
                          style: TextStyle(
                            fontSize: 16.0,
                            // fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.home),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          "355/2 A ,Pirivena road ,Mount Lavenia",
                          style: TextStyle(
                            fontSize: 16.0,
                            // fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              primary: Color(0xff001B61),
                              textStyle: const TextStyle(fontSize: 16)),
                          onPressed: () {},
                          child: const Text('View the bus route'),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              primary: Color(0xff001B61),
                              textStyle: const TextStyle(fontSize: 16)),
                          onPressed: () {},
                          child: const Text('Notify the driver'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 4.0, 12.0, 0.0),
                  child: Text(
                    "Status",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
            SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(12.0),
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 251, 252, 253),
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                ),
                child: Column(
                  children: <Widget>[
                    TimelineTile(
                        alignment: TimelineAlign.start,
                        isFirst: true,
                        indicatorStyle: IndicatorStyle(
                          width: 40,
                          height: 40,
                          padding: const EdgeInsets.all(8),
                          indicator: Icon(
                            Icons.notifications_active_rounded,
                            color: isReminder1 ? Colors.orange : Colors.grey,
                          ),
                        ),
                        endChild: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("06:30 AM"),
                              const SizedBox(
                                width: 20.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Reminder 1",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text("345 Dehiwala")
                                ],
                              ),
                            ],
                          ),
                        )),
                    TimelineTile(
                        alignment: TimelineAlign.start,
                        beforeLineStyle: LineStyle(
                          color: isPickedup ? Colors.orange : Colors.grey,
                          thickness: 1,
                        ),
                        afterLineStyle: LineStyle(
                          color: isAtSchool ? Colors.orange : Colors.grey,
                          thickness: 1,
                        ),
                        indicatorStyle: IndicatorStyle(
                          width: 40,
                          height: 40,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          drawGap: true,
                          indicator: Icon(
                            Icons.location_pin,
                            color: isPickedup ? Colors.orange : Colors.grey,
                          ),
                        ),
                        endChild: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("06:45 AM"),
                              const SizedBox(
                                width: 20.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Pick up",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text("345 Dehiwala")
                                ],
                              ),
                            ],
                          ),
                        )),
                    TimelineTile(
                        alignment: TimelineAlign.start,
                        beforeLineStyle: LineStyle(
                          color: isAtSchool ? Colors.orange : Colors.grey,
                          thickness: 1,
                        ),
                        afterLineStyle: LineStyle(
                          color: isReminder2 ? Colors.orange : Colors.grey,
                          thickness: 1,
                        ),
                        indicatorStyle: IndicatorStyle(
                          width: 40,
                          height: 40,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          drawGap: true,
                          indicator: Icon(
                            Icons.school_rounded,
                            color: isAtSchool ? Colors.orange : Colors.grey,
                          ),
                        ),
                        endChild: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("07:10 AM"),
                              const SizedBox(
                                width: 20.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "At school",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text("Royal college")
                                ],
                              ),
                            ],
                          ),
                        )),
                    TimelineTile(
                        alignment: TimelineAlign.start,
                        beforeLineStyle: LineStyle(
                          color: isReminder2 ? Colors.orange : Colors.grey,
                          thickness: 1,
                        ),
                        afterLineStyle: LineStyle(
                          color: isDroped ? Colors.orange : Colors.grey,
                          thickness: 1,
                        ),
                        indicatorStyle: IndicatorStyle(
                          width: 40,
                          height: 40,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          drawGap: true,
                          indicator: Icon(
                            Icons.notifications_active_rounded,
                            color: isReminder2 ? Colors.orange : Colors.grey,
                          ),
                        ),
                        endChild: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("14:20 PM"),
                              const SizedBox(
                                width: 20.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Reminder 2",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text("Royal college")
                                ],
                              ),
                            ],
                          ),
                        )),
                    TimelineTile(
                        alignment: TimelineAlign.start,
                        isLast: true,
                        beforeLineStyle: LineStyle(
                          color: isDroped ? Colors.orange : Colors.grey,
                          thickness: 1,
                        ),
                        indicatorStyle: IndicatorStyle(
                          width: 40,
                          height: 40,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          drawGap: true,
                          indicator: Icon(
                            Icons.location_pin,
                            color: isDroped ? Colors.orange : Colors.grey,
                          ),
                        ),
                        endChild: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("14:40 PM"),
                              const SizedBox(
                                width: 20.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Drop",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text("345 Dehiwala")
                                ],
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
