import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:parking/map.dart';
import 'package:parking/views/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  int? entryTime;

  String? token,number;

  void isLoggedIn() async {
    prefs = await SharedPreferences.getInstance();
    String? _seenNull = prefs.getString('token');
    if (_seenNull == null) {
      checkForToken = 0;
    } else {
      checkForToken = 1;
      token = prefs.getString('token');
      number = prefs.getString('number');
      entryTime = prefs.getInt('entryTime');
    } 
    setState(() {});
  }

  @override
  void initState() {
    isLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: checkForToken == -1
          ? const Center(child: CircularProgressIndicator())
          : checkForToken == 1
              ? Navigation(
                  number: number ?? '',
                  entryTime: entryTime ?? 0,
                  token: token ?? '',
                )
              : Login(),
    );
  }
}
