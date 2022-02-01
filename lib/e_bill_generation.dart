import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parking/views/login.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class EBill extends StatefulWidget {
  final int entryTime;
  final String number;
  EBill({required this.entryTime, required this.number});

  @override
  State<EBill> createState() => _EBillState();
}

class _EBillState extends State<EBill> {
  late int days, hours, seconds, minutes, totalAmount = 0;
  late Razorpay razorpay;
  late String tokenName, numberString;
  late Timer timer;

  void openCheckout() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    tokenName = token ?? '';
    var options = {
      "key": "rzp_test_WILXWxUdsDfa9S",
      "amount": totalAmount * 100,
      "name": tokenName,
      "description": "Payment For the Parking",
      "prefill": {
        "contact": widget.number,
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
    final prefs = await SharedPreferences.getInstance();
    String isToken = prefs.getString('token') ?? "";
    final databaseRef = FirebaseDatabase.instance.reference().child('users');
    databaseRef.get().then((DataSnapshot value) {
      Map<String, dynamic> data = jsonDecode(jsonEncode(value.value));
      bool found = false;

      data.forEach((docId, docValue) {
        if (docId.toString() == isToken) {
          FirebaseDatabase.instance.reference().child('users/$isToken').update(
            {"payment": true},
          );
        }
      });

      FirebaseDatabase.instance
          .ref()
          .update({"parking-system-5f1ab-default-rtdb": "true"});
          // .child('parking-system-5f1ab-default-rtdb')
    });

    // removing data

    prefs.remove('token');

    // // updating data to firebase
    // var collection = FirebaseFirestore.instance.collection("users");
    // var querySnapShot = await collection.get();
    // bool found = false;
    // for (var queryDocumentSnapShot in querySnapShot.docs) {
    //   Map<String, dynamic> data = queryDocumentSnapShot.data();
    //   if (data["token"] == tokenName && data["payment"] == false) {
    //     FirebaseFirestore.instance
    //         .collection('users')
    //         .doc(queryDocumentSnapShot.id)
    //         .update(
    //       {"payment": true},
    //     );
    //   }
    // }
  }

  void handlerPaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(msg: "Payment Successful");
    paymentDone();
    timer.cancel();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

  void handlerErrorSuccess(PaymentFailureResponse response) {
    print(response.message);
    Fluttertoast.showToast(msg: "Payment UnSuccessful. Some error Occured :(");
  }

  void calculateTotalTime() {
    var currTime = DateTime.now();
    var enteredTime =
        DateTime.fromMicrosecondsSinceEpoch(widget.entryTime * 1000);
    var diff = currTime.difference(enteredTime);
    if (diff.inMinutes > 1440)
      days = diff.inDays;
    else
      days = 0;
    if (diff.inMinutes < 60) {
      minutes = diff.inMinutes;
      hours = 0;
    } else if (diff.inMinutes > 1440) {
      double h = diff.inMinutes / 1440;
      hours = h.toInt();
      minutes = diff.inMinutes % 60;
    }
    String sec = diff.inSeconds.toString();
    sec = sec.substring(sec.length - 2);
    seconds = int.parse(sec);
    seconds = seconds < 60 ? seconds : seconds % 60;
    totalAmount = (days * 200) + (hours * 10) + (minutes * 4);
    setState(() {});
  }

  @override
  void initState() {
    calculateTotalTime();
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorSuccess);
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      calculateTotalTime();
    });
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bill'),
      ),
      body: SafeArea(
          child: Center(
        child: Card(
          elevation: 10.0,
          child: Container(
            width: MediaQuery.of(context).size.width / 2 +
                MediaQuery.of(context).size.width / 3,
            height: MediaQuery.of(context).size.height / 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ListTile(
                  title: const Text(
                    'No Of Days :',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  trailing: Text(
                    '${days.toString()} days',
                    style: const TextStyle(fontSize: 20.0),
                  ),
                ),
                ListTile(
                  title: const Text(
                    'No Of Hours :',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  trailing: Text(
                    '${hours.toString()} hours',
                    style: const TextStyle(fontSize: 20.0),
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Minutes :',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  trailing: Text(
                    '${minutes.toString()} minutes',
                    style: const TextStyle(fontSize: 20.0),
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Seconds :',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  trailing: Text(
                    '${seconds.toString()} seconds',
                    style: const TextStyle(fontSize: 20.0),
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Total Amount :',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  trailing: Text(
                    '${totalAmount.toString()} Rs',
                    style: const TextStyle(fontSize: 20.0),
                  ),
                ),
                RaisedButton(
                  onPressed: openCheckout,
                  color: Colors.blue,
                  padding: const EdgeInsets.all(10.0),
                  child: const Text(
                    "Pay Bill",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
