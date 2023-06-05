import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:swift_elearning/components/AppBar.dart';
import 'package:http/http.dart' as http;
import 'package:swift_elearning/components/DataSoal.dart';
import 'dart:convert';

import 'package:swift_elearning/components/env.dart';

void main() => runApp(const MyHomeApp());

class MyHomeApp extends StatelessWidget {
  const MyHomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SoalDynamic(id_video: 1),
    );
  }
}

class SoalDynamic extends StatefulWidget {
  SoalDynamic({super.key, required this.id_video});

  int id_video;

  @override
  State<SoalDynamic> createState() => _SoalDynamicState();
}


class _SoalDynamicState extends State<SoalDynamic> {
  late TugasPembelajaran tugasPembelajaran;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future fetchData() async {
    try {
      FlutterSecureStorage storage = FlutterSecureStorage();
      final response = await http.get(
        Uri.parse("${Env.instance.get("API_URL")}/video/tugas?"),
        headers: {
          'Authorization': "Bearer ${await storage.read(key: "jwt")}"
        }
      );

      if(response.statusCode != 200){
        throw Exception(response.body);
      }

      // Convert response body to tugasPembelajaran
      Map<String, dynamic> responseData = json.decode(response.body);
      tugasPembelajaran = TugasPembelajaran.fromJson(responseData);
      print(tugasPembelajaran.toString());
      print("================================================\n");
      print(responseData);

    } catch (exc) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text('Unknown exception: $exc'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      body: Column(
        children: [
          // TODO 
        ],
      )
    );
  }
}
