import 'package:flutter/material.dart';
import 'package:swift_elearning/materi.dart';
import '/components/AppBar.dart';
import '/profil.dart';

import 'soal_biologi.dart';
import 'soal_sejarah.dart';


void main() => runApp(const TugasPage());

class TugasPage extends StatelessWidget {
  const TugasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(context),
        body: const LisTileExample(),
      );
  }
}

class LisTileExample extends StatefulWidget {
  const LisTileExample({super.key});

  @override
  State<LisTileExample> createState() => _LisTileExampleState();
}

class _LisTileExampleState extends State<LisTileExample>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.navigate_before),
              tooltip: 'Go to the before page',
              onPressed: () {
                 Navigator.pop(context);
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(150, 30),
                primary: Colors.white,
                onPrimary: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DaftarMateri()),
                  );
              },
              child: const Text(
                'MATERI',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(150, 30),
                primary: Colors.grey,
                onPrimary: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TugasPage()),
                  );
              },
              child: const Text(
                'TUGAS',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Hero(
          tag: 'ListTile-Hero-1',
          // Wrap the ListTile in a Material widget so the ListTile has someplace
          // to draw the animated colors during the hero transition.
          child: Material(
            child: ListTile(
              title: const Text('Sejarah'),
              subtitle: const Text(
                'Indonesia',
                style: TextStyle(color: Colors.black),
              ),
              tileColor: Colors.grey,
              onTap: () {
                Navigator.push(context, MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return const soal_sejarah();
                  },
                ));
              },
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Hero(
          tag: 'ListTile-Hero-2',
          // Wrap the ListTile in a Material widget so the ListTile has someplace
          // to draw the animated colors during the hero transition.
          child: Material(
            child: ListTile(
              title: const Text('Biologi'),
              subtitle: const Text(
                'Hewan',
                style: TextStyle(color: Colors.black),
              ),
              tileColor: Colors.grey,
              onTap: () {
                Navigator.push(context, MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return const soal_biologi();
                  },
                ));
              },
            ),
          ),
        ),
      ],
    );
  }
}
