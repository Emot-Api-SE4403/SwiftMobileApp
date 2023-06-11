import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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

  String profilePictureUrl = "https://i.gifer.com/ZKZx.gif";
  String fullName = "Loading...";
  String jurusan = "Loading...";
  String asalSekolah = "Loading...";
  String email = "Loading...";
  String since = "Loading...";

  @override
  void initState(){
    super.initState();
    _retrieveData();
  }

  Future<void> _retrieveData() async {
    final storage = FlutterSecureStorage();
    profilePictureUrl = await storage.read(key: 'profile_picture') ?? 'https://iili.io/HrZtFQs.th.png';
    fullName = await storage.read(key: 'nama_lengkap') ?? "Error has occured";
    jurusan = await storage.read(key: 'jurusan') ?? "Error has occured";
    asalSekolah = await storage.read(key: 'asal_sekolah') ?? "Error has occured";
    email = await storage.read(key: 'email') ?? "Error has occured";
    since = await storage.read(key: 'time_created') ?? "Error has occured";
    var time = since.split('T');
    since = time[0];
    setState(() {}); // Update the widget's state to trigger a rebuild
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      body: Stack(
        children: [
          Align(
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
                      iconSize: 32,
                      icon: const Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute<void>(
                          builder: (BuildContext context) {
                            return const SettingPage(title: '',);
                          },
                        ));
                      },
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: IconButton(
                      iconSize: 32,
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.grey[50],
                      ),
                      onPressed: () => Navigator.popUntil(context, ModalRoute.withName("/")),
                    )
                  ),
                  Positioned(
                    top: 100,
                    left: 0,
                    child: Container(
                      width: 350,
                      child: Text(
                      '$fullName',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    )
                  ),
                  Positioned(
                    top: 140,
                    left: 20,
                    child: Container(
                      width: 330,
                      child: Text(
                      'JURUSAN                    : $jurusan',
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    )
                  ),
                  Positioned(
                    top: 170,
                    left: 20,
                    child: Container(
                      width: 330,
                      child: Text(
                        'ASAL SEKOLAH         : $asalSekolah',
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 200,
                    left: 20,
                    child: Container(
                      width: 330,
                      child: Text(
                        'EMAIL                          : $email',
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 230,
                    left: 20,
                    child: Container(
                      width: 330,
                      child: Text(
                        'BERGABUNG SEJAK  : $since',
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
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
          Align(
            alignment: const Alignment(0, -0.813),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage( profilePictureUrl // Get value from secure storage with key = "profile_picture",
                  )
                )
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
                
              ),
            ),
          ),
          /**
          Align(
            alignment: const Alignment(0, 0.6),
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
           */
        ],
      ),
    );
  }
}


