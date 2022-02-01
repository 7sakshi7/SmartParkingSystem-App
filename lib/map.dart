import 'package:flutter/material.dart';

class areaMap extends StatefulWidget {
  const areaMap({Key? key}) : super(key: key);

  @override
  _areaMapState createState() => _areaMapState();
}

class _areaMapState extends State<areaMap> {
  List<bool> isEmpty = [false, false, false, false, false, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Floors",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.purple[100],
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: const Text(
                    "1F",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 14),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: const Text(
                    "2F",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 14),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: const Text(
                    "3F",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 14),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: InteractiveViewer(
              panEnabled: false, // Set it to false to prevent panning.
              boundaryMargin: EdgeInsets.all(10),
              minScale: 0.5,
              maxScale: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isEmpty[0] = !isEmpty[0];
                                });
                              },
                              child: Container(
                                child: const Center(child: Text("1",style: TextStyle(fontSize: 20.0),)),
                                height: MediaQuery.of(context).size.height / 5,
                                width: MediaQuery.of(context).size.width / 9 +
                                    MediaQuery.of(context).size.width / 5,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  color: isEmpty[0] == false
                                      ? Colors.red
                                      : Colors.green,
                                ),
                              ),
                            ),
                            Container(

                              height: MediaQuery.of(context).size.height / 5,
                              width: MediaQuery.of(context).size.width / 9 +
                                  MediaQuery.of(context).size.width / 5,
                              decoration: const BoxDecoration(
                                border: Border(
                                  left: BorderSide(color: Colors.black),
                                  top: BorderSide(color: Colors.black),
                                  right: BorderSide(color: Colors.black),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isEmpty[1] = !isEmpty[1];
                                });
                              },
                              child: Container(
                                child: const Center(child: Text("4",style: TextStyle(fontSize: 20.0),)),
                                height: MediaQuery.of(context).size.height / 5,
                                width: MediaQuery.of(context).size.width / 9 +
                                    MediaQuery.of(context).size.width / 5,
                                decoration: BoxDecoration(
                                  color: isEmpty[1] == false
                                      ? Colors.red
                                      : Colors.green,
                                  border: Border.all(color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isEmpty[2] = !isEmpty[2];
                                });
                              },
                              child: Container(
                                child: const Center(child: Text("2",style: TextStyle(fontSize: 20.0),)),
                                height: MediaQuery.of(context).size.height / 5,
                                width: MediaQuery.of(context).size.width / 9 +
                                    MediaQuery.of(context).size.width / 5,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  color: isEmpty[2] == false
                                      ? Colors.red
                                      : Colors.green,
                                ),
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height / 5,
                              width: MediaQuery.of(context).size.width / 9 +
                                  MediaQuery.of(context).size.width / 5,
                              decoration: const BoxDecoration(
                                // color: isEmpty[3] == false ? Colors.red : Colors.green,
                                border: Border(
                                    left: BorderSide(color: Colors.black),
                                    right: BorderSide(color: Colors.black)),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isEmpty[3] = !isEmpty[3];
                                });
                              },
                              child: Container(
                                child: const Center(child: Text("5",style: TextStyle(fontSize: 20.0),)),
                                height: MediaQuery.of(context).size.height / 5,
                                width: MediaQuery.of(context).size.width / 9 +
                                    MediaQuery.of(context).size.width / 5,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  color: isEmpty[3] == false
                                      ? Colors.red
                                      : Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isEmpty[4] = !isEmpty[4];
                                });
                              },
                              child: Container(
                                child: const Center(child: Text("3",style: TextStyle(fontSize: 20.0),)),
                                height: MediaQuery.of(context).size.height / 5,
                                width: MediaQuery.of(context).size.width / 9 +
                                    MediaQuery.of(context).size.width / 5,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  color: isEmpty[4] == false
                                      ? Colors.red
                                      : Colors.green,
                                ),
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height / 5,
                              width: MediaQuery.of(context).size.width / 9 +
                                  MediaQuery.of(context).size.width / 5,
                              decoration: const BoxDecoration(
                                border: Border(
                                    left: BorderSide(color: Colors.black),
                                    right: BorderSide(color: Colors.black)),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isEmpty[5] = !isEmpty[5];
                                });
                              },
                              child: Container(
                                child: const Center(child: Text("6",style: TextStyle(fontSize: 20.0),)),
                                height: MediaQuery.of(context).size.height / 5,
                                width: MediaQuery.of(context).size.width / 9 +
                                    MediaQuery.of(context).size.width / 5,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  color: isEmpty[5] == false
                                      ? Colors.red
                                      : Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Exit",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                                RotatedBox(
                                  quarterTurns: 2,
                                  child: Container(
                                    height: 100,
                                    // width: 40,
                                    child: Image(
                                      image: AssetImage(
                                          'assets/images/arrow2.png'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 50.0,
                            ),
                            Row(
                              children: [
                                RotatedBox(
                                  quarterTurns: 3,
                                  child: Container(
                                    height: 100,
                                    // width: 40,
                                    child: Image(
                                      image: AssetImage('assets/images/arrow2.png'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Entry",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  // GestureDetector(
                  // onTap: () {
                  // openCheckout();
                  // },
                  // child: Container(
                  // width: MediaQuery.of(context).size.width,
                  // color: Colors.blue,
                  // height: 50,
                  // child: const Center(
                  // child: Text(
                  // 'Pay Bill',
                  // style: TextStyle(color: Colors.white, fontSize: 20.0),
                  // ),
                  // ),
                  // ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
