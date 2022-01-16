import 'package:flutter/material.dart';
import 'package:cs6234/home/Toolbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cs6234/home/Dashboard.dart';

class Medicines extends StatefulWidget {
  const Medicines({Key? key}) : super(key: key);

  @override
  _MedicinesState createState() => _MedicinesState();
}

class _MedicinesState extends State<Medicines> {

  final firestoreInstance = FirebaseFirestore.instance;
  String medicine = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const ToolBar(title: "Medicines"),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: TextField( // or using TextFormField and change initialValue
                controller: TextEditingController()..text = medicine,
                decoration: const InputDecoration(hintText: "Medicine"),
                keyboardType: TextInputType.name,
                onChanged: (value){
                  medicine = value;
                },
              )
            )
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
            child: MaterialButton(
              minWidth: double.infinity,
              color: Colors.lightBlue,
              child: const Text('Submit Medicines', style: TextStyle(color: Colors.white)),
              onPressed: () async {
                firestoreInstance.collection("Medicines").add({
                  "medicine" : medicine,
                  "submitTime" : Timestamp.now()
                }).then((value){
                  print(value.id);
                  Navigator.pop(context);
                  // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>
                  //   const Dashboard()
                  // ));
                });
              }
            ),
          )
        ]
      )
    );
  }
}