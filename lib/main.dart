import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

import 'intro.dart';
import 'home.dart';
import 'Dashboard.dart';
import 'profil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

AndroidOptions _getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );

class MyApp extends StatefulWidget {
  MyApp({super.key});

  final storage = FlutterSecureStorage();

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

    // Check if there is jwe
    if (jwt != null) {
      setState(() {
        _hasJwt = true;
      });
    }
    ;

    // Check if jwt still valid
    if( _hasJwt ){
      String url = "${dotenv.get("API_URL")}/pelajar/mydata";

      final response = await http
          .get(Uri.parse(url), headers: {'Authorization': 'Bearer ${jwt!}'});

      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);

        map.forEach((key, value) async {
          if (value is DateTime) {
            await widget.storage
                .write(key: key, value: value.toIso8601String());
          } else {
            await widget.storage.write(key: key, value: value.toString());
          }
        });
      } else if (response.statusCode == 401) {
        setState(() {
          _hasJwt = false;
          widget.storage.deleteAll();
        });
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
      home: _hasJwt ? DashboardPage() : const Intro(),
    );
  }
}
