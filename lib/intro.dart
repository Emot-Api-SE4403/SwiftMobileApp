import 'package:flutter/material.dart';
import '/intro/intro1.dart';
import '/intro/intro2.dart';
import '/intro/intro3.dart';
import '/intro/welcome.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> with SingleTickerProviderStateMixin {
  late TabController _controller;
  final List<Widget> _pages = const [
    Intro1(),
    Intro2(),
    Intro3(),
    Welcome()
  ];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: _pages.length, vsync: this);
    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DefaultTabController(
            length: _pages.length,
            child: TabBarView(
              controller: _controller,
              children: _pages,
            ),
          ),
          Container(
            
            alignment: const Alignment(0,0.85),
            child: TabPageSelector(
              controller: _controller,
              color: Colors.grey,
              selectedColor: Colors.black,
            ),
          )
        
        ]
      ),
    );
  }
}
