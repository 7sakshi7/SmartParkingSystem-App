import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parking/map.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';

class Login extends StatelessWidget {
  TextEditingController textEditingController = TextEditingController();
  final databaseRef = FirebaseDatabase.instance.reference();

  Login({Key? key}) : super(key: key);

  void addFields(entryTime, token, number) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('entryTime', entryTime);
    prefs.setString('token', token);
    prefs.setString('number', number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Enter your Uniquely generated token number...",
              style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28
              ),
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
                // databaseRef.child('users').get().then(
                //       (dataSnapshot) => {
                //          var user = dataSnapshot.value
                //       }
                //     );
                FocusScope.of(context).focusedChild!.unfocus();
                var collection = FirebaseFirestore.instance.collection("users");
                var querySnapShot = await collection.get();
                bool found = false;
                for (var queryDocumentSnapShot in querySnapShot.docs) {
                  Map<String, dynamic> data = queryDocumentSnapShot.data();
                  if (data["token"] == textEditingController.text &&
                      data["payment"] == false) {
                    addFields(data["entryTime"], data["token"], data["number"]);
                    found = true;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Navigation(
                          entryTime: data["entryTime"],
                          token: data["token"],
                          number: data["number"],
                        ),
                      ),
                    );
                  }
                }
                if (!found) {
                  Fluttertoast.showToast(msg: "No Such Token Exist");
                  textEditingController.text = "";
                }
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
  }
}
