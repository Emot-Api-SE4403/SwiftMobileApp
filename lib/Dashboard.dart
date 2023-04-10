import 'package:flutter/material.dart';
import 'package:swift_elearning/components/AppBar.dart';
import 'package:swift_elearning/materi.dart';
import 'package:swift_elearning/profil.dart';



void main() => runApp(const DashboardPage());

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<Map<String, dynamic>> detailMapel = [
    {
      'nama': 'Kuantitatif',
      'foto': 'assets\\image\\kuantitatif.jpeg',
    },
    {
      'nama': 'Penalaran Matematika',
      'foto': 'assets\\image\\Penalaran_MTK.jpeg',
    },
    {
      'nama': 'Penalaran Umum',
      'foto': 'assets\\image\\Penalaran_Umum.jpeg',
    },
    {
      'nama': 'Literasi \nBahasa Indonesia',
      'foto': 'assets\\image\\Literasi_Indo.jpeg',
    },
    {
      'nama': 'Literasi \nBahasa Inggris',
      'foto': 'assets\\image\\Literasi_Inggris.jpeg',
    },
    {
      'nama': 'Kemampuan Memahami \nBacaan & Menulis',
      'foto': 'assets\\image\\KMBDM.jpeg',
    },
  ];

  Widget mapel(String namaMapel) {
    final Map<String, dynamic> selectedMapel = detailMapel.firstWhere(
        (element) => element['nama'] == namaMapel,
        orElse: () => {});

    return InkWell(
      onTap: () {
        // Action
        
        Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DaftarMateri()),
                  );
        
      },
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
                image:
                    DecorationImage(image: AssetImage(selectedMapel['foto']))),
            child: Center(
              child: SizedBox(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.only(top: 95),
                  child: OverflowBox(
                    maxWidth: double.infinity,
                    maxHeight: double.infinity,
                    child: Text(
                      selectedMapel['nama'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
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
              margin: const EdgeInsets.all(60),
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
                      mapel('Penalaran Matematika'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      mapel('Literasi \nBahasa Inggris'),
                      mapel('Literasi \nBahasa Indonesia'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      mapel('Penalaran Umum'),
                      mapel('Kemampuan Memahami \nBacaan & Menulis'),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 20,
              left: 55,
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
                    MaterialPageRoute(builder: (context) => ProfilePage(title: '',)),
                  )
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets\\image\\profile_picture.jpeg'),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Positioned(
              top: 35,
              left: 150,
              child: Text(
                'namaUser',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
