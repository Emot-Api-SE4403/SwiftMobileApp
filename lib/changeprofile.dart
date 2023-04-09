import 'package:flutter/material.dart';
import '/components/AppBar.dart';

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
      home: const ChangeProfilePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class ChangeProfilePage extends StatefulWidget {
  const ChangeProfilePage({super.key, required this.title});

  final String title;
  final double _appBarHeight = 100.0;

  @override
  Size get preferredSize => Size.fromHeight(_appBarHeight);

  @override
  _ChangeProfilePageState createState() => _ChangeProfilePageState();
}

class _ChangeProfilePageState extends State<ChangeProfilePage> {
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
                const Text('UBAH PROFIL'),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Konfirmasi'),
                          content: const Text(
                              'Apakah anda yakin akan mengubah data pada profil ini?'),
                          actions: [
                            TextButton(
                              child: const Text('YA'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Pemberitahuan'),
                                      content: const Text(
                                          'Data ini telah berhasil disimpan.'),
                                      actions: [
                                        TextButton(
                                          child: const Text('OK'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
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
              height: 600.0,
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
                        labelText: 'NAMA*',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'EMAIL*',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Nomor HP*',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  leading: const Icon(Icons.camera_alt),
                                  title: const Text('Ambil Foto dari Kamera'),
                                  onTap: () {
                                    // kode ketika tombol kamera ditekan
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.photo),
                                  title: const Text('Ambil Foto dari Galeri'),
                                  onTap: () {
                                    // kode ketika tombol galeri ditekan
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const TextField(
                        decoration: InputDecoration(
                          labelText: 'UPLOAD FOTO*',
                          suffixIcon: Icon(Icons.upload),
                        ),
                        enabled: false,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'JURUSAN*',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'SEKOLAH*',
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
}
