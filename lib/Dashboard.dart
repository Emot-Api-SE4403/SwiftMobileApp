import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Map<String, dynamic>> detailMapel = [
    {
      'nama': 'Kuantitatif',
      'foto': 'image\\kuantitatif.jpeg',
    },
    {
      'nama': 'Penalaran Matematika',
      'foto': 'image\\Penalaran_MTK.jpeg',
    },
    {
      'nama': 'Penalaran Umum',
      'foto': 'image\\Penalaran_Umum.jpeg',
    },
    {
      'nama': 'Literasi \nBahasa Indonesia',
      'foto': 'image\\Literasi_Indo.jpeg',
    },
    {
      'nama': 'Literasi \nBahasa Inggris',
      'foto': 'image\\Literasi_Inggris.jpeg',
    },
    {
      'nama': 'Kemampuan Memahami \nBacaan & Menulis',
      'foto': 'image\\KMBDM.jpeg',
    },
  ];

  Widget mapel(String namaMapel) {
    final Map<String, dynamic> selectedMapel = detailMapel.firstWhere(
        (element) => element['nama'] == namaMapel,
        orElse: () => {});

    return InkWell(
      onTap: () {
        // Action
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
                      style: TextStyle(
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
          SizedBox(height: 8),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard',
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Swift \nE-Learning',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          actions: <Widget>[
            IconButton(
              color: Colors.black,
              icon: const Icon(Icons.search),
              tooltip: 'search',
              onPressed: () {},
            ),
            IconButton(
              color: Colors.black,
              icon: const Icon(Icons.notifications),
              tooltip: 'pemberitahuan',
              onPressed: () {},
            ),
          ],
          backgroundColor: Colors.grey,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
        ),
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.all(60),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Color.fromARGB(255, 209, 208, 208)),
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
                    color: Color.fromARGB(255, 209, 208, 208),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('image\\profile_picture.jpeg'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
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
