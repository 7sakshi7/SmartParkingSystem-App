import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatefulWidget {
  final String token;
  Home({required this.token});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Razorpay razorpay;
  TextEditingController textEditingController = TextEditingController();

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
    var options = {
      "key": "rzp_test_WILXWxUdsDfa9S",
      "amount": num.parse(textEditingController.text)*100,
      "name": "Sample App",
      "description": "Payment For the application",
      "prefill": {
        "contact": "8267834567",
        "email": "test@test.com",
      },
      "external": {
        "wallets": ["paytm"]
      }
    };

    // opening the payment gateway
    try{
      razorpay.open(options);
    }catch(err){
      print(err.toString());
    }
  }

  void handlerPaymentSuccess() {
    Fluttertoast.showToast(msg: "Payment Successful");
  }

  void handlerErrorSuccess() {
    Fluttertoast.showToast(msg: "Payment UnSuccessful. Some error Occured :(");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Razor Pay'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            TextField(
              controller: textEditingController,
              decoration: const InputDecoration(hintText: 'Enter Amount'),
            ),
           const SizedBox(
              height: 12,
            ),
            RaisedButton(
              color: Colors.blue,
              onPressed: (){
                openCheckout();
              },
              child: const Text(
                "Pay Now",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
