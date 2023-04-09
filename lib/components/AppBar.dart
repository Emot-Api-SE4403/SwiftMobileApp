import 'package:flutter/material.dart';

import 'searchPage.dart';
import '/tugas.dart';

PreferredSizeWidget myAppBar(context) {
  return AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.lightBlue,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
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
              onPressed: () {
                //Fungsi jika search ditekan
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPage()),
                );
              },
            ),
            IconButton(
              color: Colors.black,
              icon: const Icon(Icons.notifications),
              tooltip: 'pemberitahuan',
              onPressed: () {
                //fungsi jika notifikasi ditekan
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TugasPage()),
                );
              },
            ),
          ],
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
        );
}
