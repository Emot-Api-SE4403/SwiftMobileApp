import 'package:flutter/material.dart';
import '/main.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = new FlutterSecureStorage();

    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            return  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Text("This is Home Page"),
                  TextButton(
                    onPressed: () {
                      storage.deleteAll(); 
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyApp()),
                      );
                      },
                    child: Text("Delete jwt data"))
                ],
              ),
              );
          },
        )
      )
    );
  }
}
