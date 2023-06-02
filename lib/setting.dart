import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '/changepass.dart';
import '/changeprofile.dart';
import '/components/AppBar.dart';
import 'main.dart';

void main() {
  runApp(const MyAppp());
}

class MyAppp extends StatelessWidget {
  const MyAppp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SettingPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class SettingPage extends StatefulWidget {
  const SettingPage({super.key, required this.title});

  final String title;
  final double _appBarHeight = 100.0;

  @override
  Size get preferredSize => Size.fromHeight(_appBarHeight);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
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
                const Text('SETTING'),
                const Spacer(),
              ],
            ),
            Container(
              width: 350.0,
              height: 300.0,
              margin: const EdgeInsets.only(top: 16.0),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(8, 144, 255, 1),
                border: Border.all(
                  color: const Color.fromRGBO(8, 144, 255, 1),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300.0, // ubah lebar button Ubah Profil
                    height: 50.0, // ubah tinggi button Ubah Profil
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute<void>(
                          builder: (BuildContext context) {
                            return const ChangeProfilePage(title: '',);
                          },
                        )); 
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(
                            255, 208, 33, 243), // ubah warna background button
                      ),
                      child: const Text('Ubah Profil'),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: 300.0, // ubah lebar button Ubah Password
                    height: 50.0, // ubah tinggi button Ubah Password
                    child: ElevatedButton(
                      onPressed: () {
                        // aksi ketika tombol "Ubah Password" ditekan
                        Navigator.push(context, MaterialPageRoute<void>(
                          builder: (BuildContext context) {
                            return const ChangePassPage(title: '',);
                          },
                        ));
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.green[600]!),
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.white)
                      ),
                      child: const Text('Ubah Password'),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: 300.0, // ubah lebar button Ubah Password
                    height: 50.0, // ubah tinggi button Ubah Password
                    child: ElevatedButton(
                      onPressed: () {
                        // aksi ketika tombol "Ubah Password" ditekan
                        final FlutterSecureStorage storage = FlutterSecureStorage();
                        storage.deleteAll();

                        Navigator.push(context, MaterialPageRoute<void>(
                          builder: (BuildContext context) {
                            return MyApp();
                          },
                        ));
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.red),
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.white)
                      ),
                      child: const Text('Log out'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
