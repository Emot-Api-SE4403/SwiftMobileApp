import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '/components/AppBar.dart';
import 'main.dart';

final storage = new FlutterSecureStorage();
/*
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ChangePassPage(title: 'Flutter Demo Home Page'),
    );
  }
}
*/

class ChangePassPage extends StatefulWidget {
  const ChangePassPage({super.key, required this.title});

  final String title;
  final double _appBarHeight = 100.0;

  @override
  Size get preferredSize => Size.fromHeight(_appBarHeight);

  @override
  _ChangePassPageState createState() => _ChangePassPageState();
}

class _ChangePassPageState extends State<ChangePassPage> {
  double _appBarHeight = 100.0;
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      body: Container(
        margin: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    // kode ketika tombol kembali ditekan
                    Navigator.of(context).pop();
                  },
                ),
                const Text('UBAH PASSWORD'),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Konfirmasi'),
                          content: const Text(
                              'Apakah anda yakin akan mengubah password akun anda?'),
                          actions: [
                            TextButton(
                              child: const Text('YA'),
                              onPressed: () {
                                try{
                                  _apiCallUbahPassword();
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Pemberitahuan'),
                                        content: const Text(
                                            'Password Telah Berhasil Diperbaharui.'),
                                        actions: [
                                          TextButton(
                                            child: const Text('OK'),
                                            onPressed: () {
                                              setState(() {
                                                storage.delete(key: "jwt");
                                                Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => MyApp()),
                                              );
                                              });
                                            
                                              
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                                catch(e){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('error ${e.toString()}')),
                                  );
                                }
                              },
                            ),
                            TextButton(
                              child: const Text('TIDAK'),
                              onPressed: () {
                                // kode untuk menyimpan data pada profil
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text('Simpan'),
                ),
              ],
            ),
            Container(
              width: 350.0,
              height: 300.0,
              margin: const EdgeInsets.only(top: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.blue,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'MASUKKAN PASSWORD LAMA*',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'MASUKKAN PASSWORD BARU*',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'KONFIRMASI PASSWORD BARU*',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  void _apiCallUbahPassword() {
    throw UnsupportedError("not yet implemented");
  }
}
