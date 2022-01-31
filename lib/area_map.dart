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
                        height: MediaQuery.of(context).size.height / 5,
                        width: MediaQuery.of(context).size.width / 9 +
                            MediaQuery.of(context).size.width / 5,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: isEmpty[0] == false ? Colors.red : Colors.green,
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
                        height: MediaQuery.of(context).size.height / 5,
                        width: MediaQuery.of(context).size.width / 9 +
                            MediaQuery.of(context).size.width / 5,
                        decoration: BoxDecoration(
                          color: isEmpty[1] == false ? Colors.red : Colors.green,
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
                        height: MediaQuery.of(context).size.height / 5,
                        width: MediaQuery.of(context).size.width / 9 +
                            MediaQuery.of(context).size.width / 5,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: isEmpty[2] == false ? Colors.red : Colors.green,
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
                        height: MediaQuery.of(context).size.height / 5,
                        width: MediaQuery.of(context).size.width / 9 +
                            MediaQuery.of(context).size.width / 5,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: isEmpty[3] == false ? Colors.red : Colors.green,
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
                        height: MediaQuery.of(context).size.height / 5,
                        width: MediaQuery.of(context).size.width / 9 +
                            MediaQuery.of(context).size.width / 5,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: isEmpty[4] == false ? Colors.red : Colors.green,
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
                        height: MediaQuery.of(context).size.height / 5,
                        width: MediaQuery.of(context).size.width / 9 +
                            MediaQuery.of(context).size.width / 5,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: isEmpty[5] == false ? Colors.red : Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
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
    );
  }
}
