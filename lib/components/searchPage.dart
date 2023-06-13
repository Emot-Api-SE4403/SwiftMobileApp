import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'MapelConverter.dart';
import '../video.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _searchQuery = '';
  List<Map<String, dynamic>> data = [];
  
  Future searchResult() async {
    try {
      const FlutterSecureStorage storage = FlutterSecureStorage();
      var judul = Uri.encodeComponent(_searchQuery);
      var url = "${dotenv.get("API_URL")}/video/list?judul=$judul";
      var result = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer ${await storage.read(key: "jwt")}"
        }
      );

      if(result.statusCode != 200){
        throw Exception("Error ${result.statusCode}, ${result.body.toString()}");
      }
      print(result.body);
      data = List<Map<String, dynamic>>.from(jsonDecode(result.body));
      setState(() {
        
      });

    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.grey[50],
        title: TextField(
          onChanged: (value) => setState(() => _searchQuery = value),
          onSubmitted: (value) => searchResult(),
          decoration: InputDecoration(
            hintText: 'Search...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Search results for: $_searchQuery'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: data.length, 
              itemBuilder: (context, i) {
                return ListTile(
                  title: Text(data[i]['judul']), 
                  subtitle: Text("${data[i]['materi']['nama']}, ${MapelConverter.fromInt(data[i]['materi']['mapel'])}".replaceAll("_", " ")),
                  onTap: () => Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => VideoPage(id: data[i]['id'])),
                  ),
                );
              }
            ),
          )
        ]
      ),
    );
  }
}
