import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'intro.dart';
import 'home.dart';
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
    if (jwt != null) {
      final response = await http.get(
        Uri.parse(
          '${const String.fromEnvironment('BACKEND_URL', defaultValue: 'http://10.0.2.2:8000')}/pelajar/mydata'
          ),
        headers: {'Authorization': 'Bearer $jwt', 'Content-Type': 'application/json',},
        
      );
      if (response.statusCode == 200) {
        setState(() {
          _hasJwt = true;
        });
      } else {
        // JWT is not valid, remove it from the storage
        await widget.storage.delete(key: 'jwt');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swift E-Learning',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _hasJwt ? ProfilePage(title: '',) : const Intro(),
    );
  }
}
