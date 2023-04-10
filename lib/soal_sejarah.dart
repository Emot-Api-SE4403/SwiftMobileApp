import 'package:flutter/material.dart';
import '/components/AppBar.dart';

import 'tugas.dart';

void main() => runApp(const soal_sejarah());

class soal_sejarah extends StatelessWidget {
  const soal_sejarah({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(context),
        body: const Center(
          child: MyStatefulWidget(),
        ),
    );
  }
}

enum SingingCharacter { jakarta, bekasi, kebumen }

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  SingingCharacter? _character = SingingCharacter.jakarta;
  final questionss = [
    'Ibukota Prov JaBar?',
  ];
  int questionIndex = 0;
  TextEditingController answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                '< SEJARAH',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        const Text('What is the capital city of Indonesia?'),
        ListTile(
          title: const Text('Jakarta'),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.jakarta,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Bekasi'),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.bekasi,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Kebumen'),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.kebumen,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              questionss[questionIndex],
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),
            Container(
              width: 200,
              child: TextField(
                controller: answerController,
                decoration: const InputDecoration(
                  hintText: 'Enter your answer',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return const TugasPage();
                },
              ));
            },
            child: const Text('Submit')),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.navigate_before),
              tooltip: 'Go to the before page',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return const TugasPage();
                  },
                ));
              },
            ),
            IconButton(
              icon: const Icon(Icons.navigate_next),
              tooltip: 'Go to the next page',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return Scaffold(
                      appBar: AppBar(
                        title: const Text('Next page'),
                      ),
                      body: const Center(
                        child: Text(
                          'This is the next page',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    );
                  },
                ));
              },
            ),
          ],
        ),
      ],
    );
  }
}
