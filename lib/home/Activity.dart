import 'package:flutter/material.dart';
import 'package:cs6234/home/Toolbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Activity extends StatefulWidget {
  const Activity({Key? key}) : super(key: key);

  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          ToolBar(title: "Activities")
        ]
      )
    );
  }
}