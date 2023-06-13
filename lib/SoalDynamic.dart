import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:swift_elearning/MengerjakanSoal.dart';
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
    fetchData();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchData();
    //try to load all your data in this method :)
  }

  Future<void> fetchData() async {
    try {
      FlutterSecureStorage storage = const FlutterSecureStorage();
      final response = await http.get(
          Uri.parse(
              "${Env.instance.get("API_URL")}/video/tugas?id_video=${widget.id_video}"),
          headers: {
            'Authorization': "Bearer ${await storage.read(key: "jwt")}"
          });

      if (response.statusCode != 200) {
        throw Exception(response.body);
      }

      // Convert response body to tugasPembelajaran
      Map<String, dynamic> responseData = json.decode(response.body);

      setState(() {
        tugasPembelajaran = TugasPembelajaran.fromJson(responseData);
      });
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
        appBar: AppBar(
          title: const Text("Kembali"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                tugasPembelajaran.judul,
                style: TextStyle(
                  fontSize: 20, // Ukuran teks (misalnya 18)
                  color: Colors.black, // Warna teks (misalnya biru)
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 50,
              ),
              Table(
                children: [
                  TableRow(children: [
                    const Text("Upaya diperbolehkan:"),
                    Text("${tugasPembelajaran.jumlahAttempt}")
                  ]),
                  TableRow(children: [
                    const Text("Dibuat pada:"),
                    Text("${tugasPembelajaran.timeCreated}")
                  ])
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MengerjakanSoal(
                              tugasPembelajaran: tugasPembelajaran,
                              noSoal: 0)));
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue)),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 90, vertical: 10),
                  child: Text(
                    "Mulai",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
