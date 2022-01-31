import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parking/views/login.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';

class Navigation extends StatefulWidget {
  final int entryTime;
  final String token;
  final String number;
  Navigation(
      {required this.entryTime, required this.token, required this.number});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  List<bool> isEmpty = [false, false, false, false, false, false];
  int amount = 0;
  late Razorpay razorpay;

  @override
  void initState() {
    super.initState();
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorSuccess);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void openCheckout() {
    var currTime = DateTime.now();
    var enteredTime =
        DateTime.fromMicrosecondsSinceEpoch(widget.entryTime * 1000);
    var diff = currTime.difference(enteredTime);
    if (diff.inDays > 0) {
      amount += diff.inDays * 100;
    }
    if (diff.inHours > 0) {
      amount += diff.inHours * 20;
    }
    String tokenName = widget.token.toString();
    String numberString = widget.number;
    amount == 0 ? 1 : amount;
    var options = {
      "key": "rzp_test_WILXWxUdsDfa9S",
      "amount": amount*100,
      "name": tokenName,
      "description": "Payment For the Parking",
      "prefill": {
        "contact": numberString,
      },
      "external": {
        "wallets": ["paytm"]
      }
    };

    // opening the payment gateway
    try {
      razorpay.open(options);
    } catch (err) {
      print(err.toString());
    }
  }

  void paymentDone() async {
    // removing data
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('entryTime');
    prefs.remove('number');

    // updating data to firebase
    var collection = FirebaseFirestore.instance.collection("users");
    var querySnapShot = await collection.get();
    bool found = false;
    for (var queryDocumentSnapShot in querySnapShot.docs) {
      Map<String, dynamic> data = queryDocumentSnapShot.data();
      if (data["token"] == widget.token && data["payment"] == false) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(queryDocumentSnapShot.id)
            .update(
          {"payment": true},
        );
      }
    }
  }

  void handlerPaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(msg: "Payment Successful");
    paymentDone();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

  void handlerErrorSuccess(PaymentFailureResponse response) {
    print(response.message);
    Fluttertoast.showToast(msg: "Payment UnSuccessful. Some error Occured :(");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.token}'),
      ),
      body: SafeArea(
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
                          height: MediaQuery.of(context).size.height / 5,
                          width: MediaQuery.of(context).size.width / 9 +
                              MediaQuery.of(context).size.width / 5,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            color:
                                isEmpty[0] == false ? Colors.red : Colors.green,
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
                            color:
                                isEmpty[1] == false ? Colors.red : Colors.green,
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
                            color:
                                isEmpty[2] == false ? Colors.red : Colors.green,
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
                            color:
                                isEmpty[3] == false ? Colors.red : Colors.green,
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
                            color:
                                isEmpty[4] == false ? Colors.red : Colors.green,
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
                            color:
                                isEmpty[5] == false ? Colors.red : Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                openCheckout();
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.blue,
                height: 50,
                child: const Center(
                  child: Text(
                    'Pay Bill',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
