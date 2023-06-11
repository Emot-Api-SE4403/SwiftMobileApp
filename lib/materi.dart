import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:swift_elearning/Dashboard.dart';
import 'package:swift_elearning/changeprofile.dart';
import 'package:swift_elearning/components/AppBar.dart';
import 'package:swift_elearning/components/env.dart';
import 'package:swift_elearning/tugas.dart';
import 'package:swift_elearning/video.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MyWidget());

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          listTileTheme: const ListTileThemeData(
        textColor: Colors.white,
      )),
      home: DaftarMateri(id: 1, nama_mapel: 'kuantitatif',)
    );
  }
}

class DaftarMateri extends StatefulWidget {
  DaftarMateri({super.key,required this.id,required this.nama_mapel});
  int id;
  String nama_mapel;

  @override
  State<DaftarMateri> createState() => _DaftarMateriState();
}

class _DaftarMateriState extends State<DaftarMateri> {
  List<Map<String, dynamic>> dataMateri = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future fetchData() async {
    FlutterSecureStorage storage = FlutterSecureStorage();
    try{
      final result = await http.get(
        Uri.parse("${Env.instance.get("API_URL")}/materi/list?id_mapel=${widget.id}"),
        headers: {
          "Authorization": "Bearer ${await storage.read(key: "jwt")}"
        }
      );


      if (result.statusCode == 200) {
        // Parse the JSON response
        final jsonData = json.decode(result.body);
        
        // Clear the existing dataMateri list
        dataMateri.clear();

        // Iterate over the parsed JSON and add it to dataMateri list
        for (var item in jsonData) {
          dataMateri.add(item as Map<String, dynamic>);
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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(context),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              
              children: [
                IconButton(
                  icon: const Icon(Icons.navigate_before),
                  tooltip: 'Kembali ke dashboard',
                  onPressed: () {
                    Navigator.popUntil(context, ModalRoute.withName("/"));
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(150, 30),
                    primary: Colors.grey,
                    onPrimary: Colors.black,
                  ),
                  onPressed: () {},
                  child: Text(
                    'MATERI',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(150, 30),
                    primary: Colors.white,
                    onPrimary: Colors.black,
                    side: BorderSide(
                      color: Colors.grey,
                      width: 2,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TugasPage(id: widget.id, namaMapel: widget.nama_mapel,)),
                    );
                  },
                  child: Text(
                    'TUGAS',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(child: Container(
              color:Colors.grey[100],
              child: ListView.builder(
                itemCount: dataMateri.length,
                itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ExpansionTile(
                        title: Text(dataMateri[index]['nama']),
                        children: dataMateri[index]['video_pembelajaran'].map<Widget>((video) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => VideoPage(id:video['id'])),
                                );
                              },
                              child: Text(video['judul']),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  }
              )
            ))
          ],
        ),
      );
  }

}
