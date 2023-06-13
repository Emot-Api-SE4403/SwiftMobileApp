import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '/components/Loading.dart';
import '/components/AppBar.dart';
import 'main.dart';
import 'package:http/http.dart' as http;

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
  TextEditingController oldPassword = new TextEditingController();
  TextEditingController newPassword = new TextEditingController();
  TextEditingController confirmPassword = new TextEditingController();

  void showDialogBerhasil () {
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
                              onPressed: () => apiCallUbahPassword()
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
                      controller: oldPassword,
                      decoration: const InputDecoration(
                        labelText: 'MASUKKAN PASSWORD LAMA*',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: newPassword,
                      decoration: const InputDecoration(
                        labelText: 'MASUKKAN PASSWORD BARU*',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: confirmPassword,
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
  
  Future<void> apiCallUbahPassword() async {
    try {
      if(newPassword.text != confirmPassword.text ){
        throw Exception("konfirmasi password tidak sesuai");
      }
      if(newPassword.text.length < 8 ){
        throw Exception("password harus minimal 8 karakter");
      }

      LoadingDialog.show(context);
      var body = {
          "email": await storage.read(key: "email"),
          "password": oldPassword.text,
          "new_password": newPassword.text,
        };
      var response = await http.post(
        Uri.parse("${dotenv.get("API_URL")}/user/newpassword"),
        body: jsonEncode(body),
        headers: {
          "Content-Type": "application/json",
        }
      );

      LoadingDialog.hide(context);
      if(response.statusCode == 200){
        showDialogBerhasil();
      } else {
        var responseBody = jsonDecode(response.body);
        throw Exception("${response.statusCode}: ${responseBody['detail']}");
      }
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(e.toString())
        ),
      );
    }
  }
}
