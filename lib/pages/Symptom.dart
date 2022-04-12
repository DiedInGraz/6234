import 'package:flutter/material.dart';
import 'package:cs6234/home/Toolbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Symptoms extends StatefulWidget {
  final String widgetSymptoms;
  final String widgetSymptomsId;
  const Symptoms({Key? key, this.widgetSymptoms = "", this.widgetSymptomsId = ""}) : super(key: key);

  @override
  _SymptomsState createState() => _SymptomsState();
}

class _SymptomsState extends State<Symptoms> {
  final authInstance = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  String symptoms = "";
  String symptomsId = "";

  String? username = "";
  List<CheckBoxListTileModel> checkBoxListTileModel = CheckBoxListTileModel.getUsers();
  List symtpomList = [];

  @override
  void initState() {
    super.initState();
    symptoms = widget.widgetSymptoms;
    symptomsId = widget.widgetSymptomsId;
    final currentUser = authInstance.currentUser;
    if (currentUser != null) {
      username = currentUser.email;
    } else {
      print("not login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: [
          const ToolBar(title: "Symptoms"),
          Flexible(
            child: ListView.builder(
              itemCount: checkBoxListTileModel.length,
              itemBuilder: (BuildContext context, int index){
                return Card(
                    child: Container(
                    padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          CheckboxListTile(
                           activeColor: Colors.pink[300],
                           dense: true,
                            //font change
                            title: Text(
                              checkBoxListTileModel[index].title,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5
                              ),
                            ),
                            value: checkBoxListTileModel[index].isCheck,
                            onChanged: null,
                            // onChanged: (bool val) {
                            //   setState(() {
                            //     // if(val) {
                            //     //   symtpomList.add(checkBoxListTileModel[index].title);
                            //     // } else {
                            //     //   symtpomList.remove(checkBoxListTileModel[index].title);
                            //     // }
                            //     //print(symtpomList);
                            //     //checkBoxListTileModel[index].isCheck = val;
                            //   });
                            // }
                          )
                        ],
                      ),
                    ),
                );
              }
            )
          )
        ]
      )
    );
  }
}

class CheckBoxListTileModel {
  String title;
  bool isCheck;

  CheckBoxListTileModel({this.title = "", this.isCheck = false});

  static List<CheckBoxListTileModel> getUsers() {
    return <CheckBoxListTileModel>[
      CheckBoxListTileModel(
          title: "Fatigue",
          isCheck: false),
      CheckBoxListTileModel(
          title: "Dizziness",
          isCheck: false),
      CheckBoxListTileModel(
          title: "Headaches",
          isCheck: false),
      CheckBoxListTileModel(
          title: "Sore throat",
          isCheck: false),
      CheckBoxListTileModel(
          title: "Muscle soreness",
          isCheck: false),
      CheckBoxListTileModel(
          title: "Fever",
          isCheck: false),
      CheckBoxListTileModel(
          title: "Loss of smell/taste ",
          isCheck: false),
      CheckBoxListTileModel(
          title: "Cough",
          isCheck: false),
    ];
  }
}