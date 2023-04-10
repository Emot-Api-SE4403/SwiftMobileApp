import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'intro.dart';
import 'home.dart';
import 'Dashboard.dart';
import 'profil.dart';

void main() async {
  runApp(MyApp());
}

AndroidOptions _getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );

class MyApp extends StatefulWidget {
  MyApp({super.key});

  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _hasJwt = false;

  @override
  void initState() {
    super.initState();
    _checkJwt();
  }

  Future<void> _checkJwt() async {
    final jwt = await widget.storage.read(key: 'jwt');
    //print(jwt);
    //print(_hasJwt);
    if( jwt != null ){
      setState(() {
        _hasJwt = true;
      });
    };
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swift E-Learning',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _hasJwt ? const DashboardPage() : const Intro(),
    );
  }
}
