import 'package:flutter/material.dart';
import '/components/AppBar.dart';
import '/setting.dart';

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
      home: const ProfilePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.title});

  final String title;
  final double _appBarHeight = 100.0;

  @override
  Size get preferredSize => Size.fromHeight(_appBarHeight);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  double _appBarHeight = 100.0;
  bool _isSearching = false;
  bool _showPopup = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      body: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: const Alignment(0, -0.45),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: const Color.fromARGB(255, 82, 82, 82),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                width: 350,
                height: 300,
                child: Stack(
                  children: [
                    Positioned(
                      top: 16,
                      right: 16,
                      child: IconButton(
                        icon: const Icon(Icons.settings),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute<void>(
                            builder: (BuildContext context) {
                              return const SettingPage(title: '',);
                            },
                          ));
                        },
                      ),
                    ),
                    const Positioned(
                      top: 80,
                      left: 80,
                      child: Text(
                        'WAWAN SUTAJO',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Positioned(
                      top: 120,
                      left: 20,
                      child: Text(
                        'JURUSAN               : SAINTEK',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const Positioned(
                      top: 150,
                      left: 20,
                      child: Text(
                        'ASAL SEKOLAH    : SMAN 1 PAPUA BARAT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const Positioned(
                      top: 180,
                      left: 20,
                      child: Text(
                        'EMAIL                     : SutajoW@Gmail.com',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const Positioned(
                      top: 210,
                      left: 20,
                      child: Text(
                        'NOMOR HP            : 081234567890',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: const Alignment(0, -0.85),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 80, 162, 164),
                ),
                width: 150,
                height: 150,
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: const Alignment(0, -0.813),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 255, 51, 51),
                ),
                width: 120,
                height: 120,
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("FOTO PROFIL"),
                          content: const Text("INI FOTO PROFIL ANDA"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Icon(
                    Icons.person,
                    size: 100,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: const Alignment(0, 0.5),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Color.fromARGB(255, 80, 162, 164),
                ),
                width: 350,
                height: 50,
                child: Row(
                  children: [
                    const Text('Riwayat Pembelian'),
                    Expanded(child: Container()),
                    InkWell(
                      onTap: () {
                        // aksi yang ingin dilakukan ketika tombol diklik
                      },
                      child: Ink(
                        padding: const EdgeInsets.all(16),
                        child: const Icon(Icons.shopping_cart),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: const Alignment(0, 0.5),
              child: Container(
                width: 350,
                height: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Color.fromARGB(255, 80, 162, 164),
                ),
                child: Row(
                  children: [
                    const Text('Riwayat Pembelian'),
                    Expanded(child: Container()),
                    InkWell(
                      onTap: () {
                        // aksi yang ingin dilakukan ketika tombol diklik
                      },
                      child: Ink(
                        padding: const EdgeInsets.all(16),
                        child: const Icon(Icons.shopping_cart),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
