import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '/components/AppBar.dart';
import '/materi.dart';
import '/profil.dart';



void main() => runApp( DashboardPage());

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class DashboardPage extends StatefulWidget {
  DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  List<Map<String, dynamic>> detailMapel = [
    {
      'nama': 'Kuantitatif',
      'foto': 'assets\\image\\kuantitatif.jpeg',
      'id': 1
    },
    {
      'nama': 'Penalaran \nMatematika',
      'foto': 'assets\\image\\Penalaran_MTK.jpeg',
      'id':2
    },
    {
      'nama': 'Penalaran Umum',
      'foto': 'assets\\image\\Penalaran_Umum.jpeg',
      'id':5
    },
    {
      'nama': 'Literasi \nBahasa Indonesia',
      'foto': 'assets\\image\\Literasi_Indo.jpeg',
      'id':4
    },
    {
      'nama': 'Literasi \nBahasa Inggris',
      'foto': 'assets\\image\\Literasi_Inggris.jpeg',
      'id':3
    },
    {
      'nama': 'Kemampuan Memahami \nBacaan & Menulis',
      'foto': 'assets\\image\\KMBDM.jpeg',
      'id':6
    },
  ];

  String profilePictureUrl = "https://i.gifer.com/ZKZx.gif";
  String fullName = "Loading...";

  @override
  void initState() {
    super.initState();
    _retrieveData();
  }

  Future<void> _retrieveData() async {
    final storage = FlutterSecureStorage();
    profilePictureUrl = await storage.read(key: 'profile_picture') ?? 'https://iili.io/HrZtFQs.th.png';
    fullName = await storage.read(key: 'nama_lengkap') ?? "Error has occured";
    setState(() {}); // Update the widget's state to trigger a rebuild
  }  

  Widget mapel(String namaMapel) {
    final Map<String, dynamic> selectedMapel = detailMapel.firstWhere(
        (element) => element['nama'] == namaMapel,
        orElse: () => {});

    return InkWell(
      onTap: () {
        // Action
        
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DaftarMateri(
              id: selectedMapel['id'], 
              nama_mapel: selectedMapel['nama'],
            )
          ),
        );
        
      },
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
                image:
                    DecorationImage(image: AssetImage(selectedMapel['foto']))),
            child: Center(
              child: SizedBox(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.only(top: 90),
                  child: OverflowBox(
                    maxWidth: double.infinity,
                    maxHeight: double.infinity,
                    child: Text(
                      selectedMapel['nama'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Dashboard',
      home: Scaffold(
        appBar: myAppBar(context),
        body: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 50, right: 50, top: 70, bottom: 50),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: const Color.fromARGB(255, 209, 208, 208)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      mapel('Kuantitatif'),
                      const SizedBox(width: 10),
                      mapel('Penalaran \nMatematika'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      mapel('Literasi \nBahasa Inggris'),
                      const SizedBox(width: 10),
                      mapel('Literasi \nBahasa Indonesia'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      mapel('Penalaran Umum'),
                      const SizedBox(width: 10),
                      mapel('Kemampuan Memahami \nBacaan & Menulis'),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 23,
              left: 45,
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 7,
                    color: const Color.fromARGB(255, 209, 208, 208),
                  ),
                ),
                child: GestureDetector(
                  onTap: () => {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfilePage(title: '',)),
                  )
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child:  Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage( profilePictureUrl // Get value from secure storage with key = "profile_picture",
                          )
                        ),
                      ),
                    )
                  ),
                ),
              ),
            ),
            Positioned(
              top: 45,
              left: 140,
              child: Text(
                fullName,
            // Get value from secure storage with key = "nama_lengkap",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
