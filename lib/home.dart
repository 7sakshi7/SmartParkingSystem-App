import 'package:flutter/material.dart';
import 'package:parking/e_bill_generation.dart';
import 'package:parking/map.dart';
import 'package:parking/rate_list.dart';
import 'package:parking/views/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:convert';

class Home extends StatefulWidget {
  final int entryTime;
  final String token;
  final String number;
  final String numberplate;
  final String parkingId;
  Home(
      {required this.entryTime,
      required this.token,
      required this.number,
      required this.numberplate,
      required this.parkingId});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final databaseRef = FirebaseDatabase.instance.ref().child('users');

  void paymentDone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Login(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.token}'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    'Welcome! ${widget.numberplate}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Card(
                    elevation: 6.0,
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const areaMap()));
                      },
                      leading: const Icon(Icons.map_outlined),
                      title: const Text("Find an Empty slot"),
                      trailing: const Icon(Icons.arrow_forward_rounded),
                    ),
                  ),
                  Card(
                    elevation: 6.0,
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    RateList(parkingId: widget.parkingId)));
                      },
                      leading: const Icon(Icons.list_alt_outlined),
                      title: const Text("See Rate List"),
                      trailing: const Icon(Icons.arrow_forward_rounded),
                    ),
                  ),
                  Card(
                    elevation: 6.0,
                    child: ListTile(
                      onTap: () async {
                        databaseRef.get().then((DataSnapshot value) {
                          Map<String, dynamic> data =
                              jsonDecode(jsonEncode(value.value));

                          data.forEach((docId, docValue) {
                            if (docId.toString() == widget.token) {
                              if (docValue["payment"] == true) {
                                paymentDone();
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EBill(
                                      entryTime: widget.entryTime,
                                      number: widget.number,
                                    ),
                                  ),
                                );
                              }
                            }
                          });
                        });
                      },
                      leading: const Icon(Icons.receipt_long_outlined),
                      title: const Text("Generate the e-bill"),
                      trailing: const Icon(Icons.arrow_forward_rounded),
                    ),
                  )
                ],
              ),
              Wrap(
                children: [
                  const Center(
                      child: Text(
                    "Your uniquely generated token number is:",
                    style: TextStyle(fontSize: 17.0),
                  )),
                  Center(
                    child: Container(
                      margin: EdgeInsets.all(10.0),
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: Colors.purple[100],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: Text(
                        widget.token,
                        overflow: TextOverflow.fade,
                        style: const TextStyle(fontSize: 30.0),
                        // softWrap: true,
                      ),
                    ),
                  ),
                  const Text(
                    "** You can use this token at exit point to leave the premises",
                    style: TextStyle(fontSize: 15.0, color: Colors.grey),
                    // softWrap: true,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
