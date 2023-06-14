import 'package:flutter/material.dart';

class TimePassedWidget extends StatelessWidget {
  final DateTime dateTime;

  const TimePassedWidget({required this.dateTime});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final timePassed = now.difference(dateTime);

    final formatter = DateFormat.Hms(); // You can adjust the format as per your needs

    return Text('${formatter.format(timePassed)} ago');
  }
}
