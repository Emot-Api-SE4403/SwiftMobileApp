import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'intro.dart';
import 'home.dart';
import 'Dashboard.dart';
import 'profil.dart';
import 'components/env.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.instance.load();
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

    // Check if there is jwe
    if( jwt != null ){
      setState(() {
        _hasJwt = true;
      });
    };

    // Check if jwt still valid
    if( _hasJwt ){
      String url = "${Env.instance.get("API_URL")!}/pelajar/mydata";

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${jwt!}'
        }
      );

      if( response.statusCode == 200){

      } else {
        setState(() {
          _hasJwt = false;
          widget.storage.delete(key: 'jwt');
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
      home: _hasJwt ? const DashboardPage() : const Intro(),
    );
  }
}
