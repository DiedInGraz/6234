import 'package:flutter/material.dart';
import 'package:cs6234/home/Toolbar.dart';

class Trip extends StatefulWidget {
  const Trip({Key? key}) : super(key: key);

  @override
  _TripState createState() => _TripState();
}

class _TripState extends State<Trip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          ToolBar(title: "Trip")
        ]
      )
    );
  }
}