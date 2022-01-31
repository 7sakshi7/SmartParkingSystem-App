import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parking/area_map.dart';
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
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children:[
                  const Text("Welcome! Number Plate",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24
                  ),),
                  const SizedBox(height: 12,),
                  Card(
                    elevation: 6.0,
                    child: ListTile(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>areaMap()));
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
                        openCheckout();
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
                  const Center(child: Text("Your uniquely generated token number is:",
                    style: TextStyle(
                        fontSize: 17.0
                    ),)),
                  Center(
                    child: Container(
                      margin: EdgeInsets.all(10.0),
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: Colors.purple[100],
                        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: Text(
                        widget.token,
                          overflow: TextOverflow.fade,
                          style: const TextStyle(
                            fontSize: 30.0
                          ),
                          // softWrap: true,
                      ),
                    ),
                  ),
                  const Text(
                    "** You can use this token at exit point to leave the premises",
                    style: TextStyle(
                        fontSize: 15.0,
                      color: Colors.grey
                    ),
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
