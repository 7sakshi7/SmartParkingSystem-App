import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:parking/home.dart';
import 'package:parking/views/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:convert';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int checkForToken = -1;

  late SharedPreferences prefs;

  late int entryTime;

  late String token, number, numberplate;
  final databaseRef = FirebaseDatabase.instance.ref().child('users');
  void isLoggedIn() async {
    prefs = await SharedPreferences.getInstance();
    String? isToken = prefs.getString('token');
    print(isToken);
    if (isToken == null) {
      checkForToken = 0;
      setState(() {});
    } else{
      databaseRef.get().then((DataSnapshot value) async{
        Map<String, dynamic> data = await jsonDecode(jsonEncode(value.value));
        bool found = false;

        data.forEach((docId, docValue) {
          print(docId.toString());
          if (docId.toString() == isToken && docValue["payment"] == false) {
            print('entered');
            found = true;
            print(docValue['entryTime'].runtimeType);
            entryTime = docValue["entryTime"];
            print("*******${entryTime}");
            token = docValue["token"];
            print("!!!!!!!${token}");
            number = docValue["number"];
            print("#######${number}");
            numberplate = docValue["nameplate"];
            print("@@@@@@@${numberplate}");
            checkForToken = 1;
            setState(() {});
          }
        });
        if (!found) {
          checkForToken = 0;
          setState(() {});
        }
      });
    }
  }

  @override
  void initState() {
    isLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: checkForToken == -1
          ? const Center(child: Scaffold(body: Center(child: CircularProgressIndicator())))
          : checkForToken == 1
              ? Home(
                  number: number,
                  entryTime: entryTime,
                  token: token,
                  numberplate: numberplate,
                )
              : Login(),
    );
  }
}
