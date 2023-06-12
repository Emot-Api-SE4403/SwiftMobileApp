import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:swift_elearning/Dashboard.dart';
import 'package:swift_elearning/Soal.dart';
import 'package:swift_elearning/components/MapelConverter.dart';
import 'package:swift_elearning/components/env.dart';
import 'package:swift_elearning/materi.dart';
import '/components/AppBar.dart';
import '/profil.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'soal_biologi.dart';
import 'soal_sejarah.dart';


void main() => runApp(const TugasPageDebug());

class TugasPageDebug extends StatelessWidget {
  const TugasPageDebug({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TugasPage(id: 1, namaMapel: 'kuantitatif',),
    );
  }
}

class TugasPage extends StatefulWidget {
  TugasPage({super.key, required this.id, required this.namaMapel});

  int id;
  String namaMapel; 

  @override
  State<TugasPage> createState() => _TugasPageState();
}

class _TugasPageState extends State<TugasPage>
    with TickerProviderStateMixin {
  List<Map<String, dynamic>> data = [];

  Future _fetchData() async {
    FlutterSecureStorage storage = FlutterSecureStorage();
    try{
      final result = await http.get(
        Uri.parse("${Env.instance.get("API_URL")}/materi/tugas/list?mapel=${MapelConverter.fromInt(widget.id)}"),
        headers: {
          "Authorization": "Bearer ${await storage.read(key: "jwt")}"
        }
      );

      if (result.statusCode == 200) {
        // Parse the JSON response
        final jsonData = json.decode(result.body);
        
        // Clear the existing dataMateri list
        data.clear();

        // Iterate over the parsed JSON and add it to dataMateri list
        for (var item in jsonData) {
          data.add(item as Map<String, dynamic>);
        }

        // Refresh the page
        setState(() {});
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('error ${result.statusCode}, ${result.body}')),
        );
      }
    } catch (exc) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent ,
          content: Text('Unknown exception: $exc')
        )
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.navigate_before),
                tooltip: 'Kembali ke Dashboard',
                onPressed: () {
                   Navigator.popUntil(context, ModalRoute.withName("/"));
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(150, 30),
                  primary: Colors.white,
                  onPrimary: Colors.black,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DaftarMateri(id: widget.id, nama_mapel: widget.namaMapel,)),
                    );
                },
                child: const Text(
                  'MATERI',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(150, 30),
                  primary: Colors.grey,
                  onPrimary: Colors.black,
                ),
                onPressed: () {},
                child: const Text(
                  'TUGAS',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(child: ListView.builder(itemCount: data.length, itemBuilder: HeroBuilder))
        ],
      ),
    );
  }


  Widget HeroBuilder(context, i){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Hero(
        tag: 'ListTile-Hero-${i+1}',
        child: Material(
          child: ListTile(
            title: Text(
              '${data[i]['judul']}',
              style: Theme.of(context).textTheme.headlineSmall?.apply(
                fontSizeDelta: -4
              ),
            ),
            subtitle:  Text(
              '${widget.namaMapel}'.replaceAll("\n", " "),
              style: TextStyle(color: Colors.black),
            ),
            trailing: Text("${data[i]['time_created'].replaceAll("T", "\n")}"),
            tileColor: Colors.grey,
            onTap: () {
              Navigator.push(context, MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return SoalDynamic(id_video: data[i]['video']['id']);
                },
              ));
            },
          ),
        ),
      ),
    );
  }
}
