import 'package:flutter/material.dart';
import 'package:cs6234/home/Toolbar.dart';

class Symptom extends StatefulWidget {
  const Symptom({Key? key}) : super(key: key);

  @override
  _SymptomState createState() => _SymptomState();
}

class _SymptomState extends State<Symptom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          ToolBar(title: "Symptom")
        ]
      )
    );
  }
}