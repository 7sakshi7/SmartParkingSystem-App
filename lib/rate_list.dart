import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RateList extends StatefulWidget {
  final String parkingId;
  RateList({required this.parkingId});

  @override
  _RateListState createState() => _RateListState();
}

class _RateListState extends State<RateList> {
  List<Map<String, dynamic>> categoryRatelist = [];
  List<String> categories = [];
  void findRateList() {
    final databaseRef = FirebaseDatabase.instance
        .ref()
        .child('parkingarea/${widget.parkingId}/ratelist');
    databaseRef.get().then((DataSnapshot value) {
      Map<String, dynamic> data = jsonDecode(jsonEncode(value.value));
      print(data);

      data.forEach((docId, docValue) {
        categories.add(docId);
        categoryRatelist.add(docValue);
      });
      setState(() {});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findRateList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bill'),
      ),
      body: categoryRatelist.length == 0
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: categoryRatelist.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 10.0),
                            child: Card(
                              elevation: 2.0,
                              child: Container(
                                // width: MediaQuery.of(context).size.width / 2,
                                // height: MediaQuery.of(context).size.height,
                                margin: EdgeInsets.only(top: 10.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        categories[index],
                                        style: const TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    ListTile(
                                      title: const Text(
                                        'Per Day',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      trailing: Text(
                                        '${categoryRatelist[index]["perday"]} Rs',
                                        style: const TextStyle(fontSize: 20.0),
                                      ),
                                    ),
                                    ListTile(
                                      title: const Text(
                                        'Per Hour',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      trailing: Text(
                                        '${categoryRatelist[index]["perhour"]} Rs',
                                        style: const TextStyle(fontSize: 20.0),
                                      ),
                                    ),
                                    ListTile(
                                      title: const Text(
                                        'Per Minute',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      trailing: Text(
                                        '${categoryRatelist[index]["perminute"]} Rs',
                                        style: const TextStyle(fontSize: 20.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
