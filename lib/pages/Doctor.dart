import 'package:flutter/material.dart';
import 'package:cs6234/home/Toolbar.dart';

class Doctor extends StatefulWidget {
  const Doctor({Key? key}) : super(key: key);

  @override
  _DoctorState createState() => _DoctorState();
}

class _DoctorState extends State<Doctor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          ToolBar(title: "Doctor")
        ]
      )
    );
  }
}