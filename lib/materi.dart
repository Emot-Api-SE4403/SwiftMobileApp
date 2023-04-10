import 'package:flutter/material.dart';
import 'package:swift_elearning/changeprofile.dart';
import 'package:swift_elearning/components/AppBar.dart';
import 'package:swift_elearning/tugas.dart';
import 'package:swift_elearning/video.dart';

void main() => runApp(const DaftarMateri());

class DaftarMateri extends StatelessWidget {
  const DaftarMateri({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          listTileTheme: const ListTileThemeData(
        textColor: Colors.white,
      )),
      home: Scaffold(
        appBar: myAppBar(context),
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
                  onPressed: () {
                    Navigator.pop(context);
                  },
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
                  onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TugasPage()),
                  );
                  },
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
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: GestureDetector(
                            onTap: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => VideoPage()),
                              )
                            },
                            child: Text('Deskripsi materi ${index + 1}'),
                          ),
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
