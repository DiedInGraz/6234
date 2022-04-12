import 'package:flutter/material.dart';
import 'package:cs6234/home/Toolbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Symptoms extends StatefulWidget {
  final String widgetSymptom;
  final String widgetSymptomId;
  const Symptoms({Key? key, this.widgetSymptom = "", this.widgetSymptomId = ""}) : super(key: key);

  @override
  _SymptomsState createState() => _SymptomsState();
}

class _SymptomsState extends State<Symptoms> {
  final authInstance = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  String symptom = "";
  String symptomId = "";

  String? username = "";

  @override
  void initState() {
    super.initState();
    symptom = widget.widgetSymptom;
    symptomId = widget.widgetSymptomId;
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
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: TextField( // or using TextFormField and change initialValue
                        controller: TextEditingController()..text = symptom,
                        decoration: const InputDecoration(hintText: "Symptom"),
                        keyboardType: TextInputType.name,
                        onChanged: (value){
                          symptom = value;
                        },
                      )
                  )
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
                child: MaterialButton(
                    minWidth: double.infinity,
                    color: Colors.lightBlue,
                    child: const Text('Submit Symptoms', style: TextStyle(color: Colors.white)),
                    onPressed: () async {
                      if(symptomId != "") {
                        firestoreInstance.collection("Symptoms").doc(symptomId).update({
                          "symptom" : symptom,
                          "username" : username,
                          "submitTime" : Timestamp.now()
                        }).then((value) => Navigator.pop(context));
                      } else {
                        firestoreInstance.collection("Symptoms").add({
                          "symptom" : symptom,
                          "username" : username,
                          "submitTime" : Timestamp.now()
                        }).then((value){
                          print(value.id);
                          Navigator.pop(context);
                          // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>
                          //   const Dashboard()
                          // ));
                        });
                      }
                    }
                ),
              )
            ]
        )
    );
  }
}