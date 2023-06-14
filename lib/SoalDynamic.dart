import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '/MengerjakanSoal.dart';
import '/components/AppBar.dart';
import 'package:http/http.dart' as http;
import '/components/DataSoal.dart';
import 'dart:convert';


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
  SoalDynamic({super.key, required this.id_video, this.id_tugas});

  int id_video;
  int? id_tugas;

  @override
  State<SoalDynamic> createState() => _SoalDynamicState();
}

class _SoalDynamicState extends State<SoalDynamic> {
  TugasPembelajaran tugasPembelajaran = TugasPembelajaran.placeholder;
  List<Map<String, dynamic>> listAttempts = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }
  Future apiCallTugas() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
      final response = await http.get(
          Uri.parse(
              "${dotenv.get("API_URL")}/video/tugas?id_video=${widget.id_video}"),
          headers: {
            'Authorization': "Bearer ${await storage.read(key: "jwt")}"
          });

      if (response.statusCode != 200) {
        throw Exception(response.body);
      }

      // Convert response body to tugasPembelajaran
      Map<String, dynamic> responseDataTugas = json.decode(response.body);
      return responseDataTugas;
  }

  Future apiCallAttempts() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    var url = "${dotenv.get("API_URL")}/video/tugas/nilai?id_tugas=${widget.id_tugas}&id_pelajar=${await storage.read(key:"id")}";
    print(url);
    final responseattempt = await http.get(
          Uri.parse(url),
          headers: {
            'Authorization': "Bearer ${await storage.read(key: "jwt")}"
          });

      if (responseattempt.statusCode != 200) {
        throw Exception(responseattempt.body);
      }

      List responseDataAttempt = json.decode(responseattempt.body);
      print(responseattempt.body);
      return responseDataAttempt;
  }

  Future<void> fetchData() async {
    try {
      final responseDataTugas = await apiCallTugas();
      final responseDataAttempts = await apiCallAttempts();
      setState(() {
        tugasPembelajaran = TugasPembelajaran.fromJson(responseDataTugas);
        listAttempts = List<Map<String, dynamic>>.from(responseDataAttempts);
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

  Widget buatDaftarAttempt(context, index) {
    return ListTile(
      title: Text("Percobaan pada ke ${index+1}"),
      subtitle: Text(listAttempts[index]["waktu_selesai"]),
      trailing: Text((10*listAttempts[index]["nilai"]).toStringAsFixed(2)),
    );
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
        body: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20,),
              Text(
                tugasPembelajaran.judul,
                style: TextStyle(
                  fontSize: 20, // Ukuran teks (misalnya 18)
                  color: Colors.black, // Warna teks (misalnya biru)
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:20.0),
                child: Table(
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
              ),
              const SizedBox(height: 20,),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal:20.0),
                child: Text(
                  "Daftar percobaan:",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    border: Border.all(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: (listAttempts.isNotEmpty ) ? 
                    ListView.builder(itemBuilder: buatDaftarAttempt, itemCount: listAttempts.length,):
                    const Text("  Belum ada attempt")
                ),
              ),
              TextButton(
                onPressed: (tugasPembelajaran.jumlahAttempt > listAttempts.length) ? () {
                  MengerjakanSoal.init(tugasPembelajaran);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MengerjakanSoal(
                              tugasPembelajaran: tugasPembelajaran,
                              noSoal: 0
                          )
                      )
                  );
                }: null,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    (tugasPembelajaran.jumlahAttempt > listAttempts.length) ?  Colors.blue : Colors.grey
                  ),
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 90, vertical: 10),
                  child: Text(
                    "Mulai",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ),
              const SizedBox(height: 30,),

            ],
          ),
        ));
  }
}
