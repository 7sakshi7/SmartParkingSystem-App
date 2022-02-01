import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parking/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:convert';

class Login extends StatelessWidget {
  TextEditingController textEditingController = TextEditingController();
  final databaseRef = FirebaseDatabase.instance.reference().child('users');

  Login({Key? key}) : super(key: key);

  void addFields(token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    print('========================================');
    print(prefs.getString('token'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Enter your Uniquely generated token number...",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              controller: textEditingController,
              decoration: const InputDecoration(hintText: 'Enter Your Token'),
            ),
            const SizedBox(
              height: 12,
            ),
            RaisedButton(
              color: Colors.blue,
              onPressed: () async {
                FocusScope.of(context).focusedChild!.unfocus();
                databaseRef.get().then((DataSnapshot value) {
                  Map<String, dynamic> data =
                      jsonDecode(jsonEncode(value.value));
                  bool found = false;

                  data.forEach((docId, docValue) {
                    print(docId.toString());
                    print(textEditingController.text.toString());
                    if (docId.toString() ==
                            textEditingController.text.toString() &&
                        docValue["payment"] == false) {
                      found = true;
                      addFields(
                        docValue["token"],
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(
                            entryTime: docValue["entryTime"],
                            token: docValue["token"],
                            numberplate: docValue["nameplate"],
                            number: docValue["number"],
                          ),
                        ),
                      );
                    }
                  });
                  if (!found) {
                    Fluttertoast.showToast(msg: "No Such Token Exist");
                    textEditingController.text = "";
                  }
                });
              },
              child: const Text(
                "Submit",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
    // return Scaffold(
    //   body: Center(
    //     child: Padding(
    //       padding: const EdgeInsets.all(30.0),
    //       child: Column(
    //         children: [
    //           TextField(
    //             controller: textEditingController,
    //             decoration: const InputDecoration(hintText: 'Enter Your Token'),
    //           ),
    //           const SizedBox(
    //             height: 12,
    //           ),
    //           RaisedButton(
    //             color: Colors.blue,
    //             onPressed: () async {
    //               databaseRef.get().then((DataSnapshot value) {
    //                 Map<String, dynamic> data =
    //                     jsonDecode(jsonEncode(value.value));
    //                 bool found = false;

    //                 data.forEach((docId, docValue) {
    //                   print(docId.toString());
    //                   print(textEditingController.text.toString());
    //                   if (docId.toString() ==
    //                           textEditingController.text.toString() &&
    //                       docValue["payment"] == false) {
    //                     found = true;
    //                     addFields(
    //                       docValue["token"],
    //                     );
    //                     Navigator.pushReplacement(
    //                       context,
    //                       MaterialPageRoute(
    //                         builder: (context) => Home(
    //                           entryTime: docValue["entryTime"],
    //                           token: docValue["token"],
    //                           numberplate: docValue["nameplate"],
    //                           number: docValue["number"],
    //                         ),
    //                       ),
    //                     );
    //                   }
    //                 });
    //                 if (!found) {
    //                   Fluttertoast.showToast(msg: "No Such Token Exist");
    //                   textEditingController.text = "";
    //                 }
    //               });
    //             },
    //             child: const Text(
    //               "Submit",
    //               style: TextStyle(color: Colors.white),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
