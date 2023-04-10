import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          listTileTheme: const ListTileThemeData(
        textColor: Colors.white,
      )),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SWIFT',
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'E-LEARNING',
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
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
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            side: BorderSide(
              color: Colors.grey,
              width: 2,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.navigate_before),
                  tooltip: 'Go to the before page',
                  onPressed: () {},
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(150, 30),
                    primary: Colors.grey,
                    onPrimary: Colors.black,
                  ),
                  onPressed: () {},
                  child: Text(
                    'MATERI',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(150, 30),
                    primary: Colors.white,
                    onPrimary: Colors.black,
                    side: BorderSide(
                      color: Colors.grey,
                      width: 2,
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'TUGAS',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ExpansionTile(
                      title: Text('Materi ${index + 1}'),
                      children: <Widget>[
                        ListTile(
                          title: Text('Deskripsi materi ${index + 1}'),
                        )
                      ],
                    ),
                  );
                },
                itemCount: 5, // Replace with actual number of cards
              ),
            ),
          ],
        ),
      ),
    );
  }
}
