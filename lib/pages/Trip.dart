import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cs6234/home/Toolbar.dart';

class Trips extends StatefulWidget {
  final String widgetTrip;
  final String widgetTripId;
  const Trips({Key? key, this.widgetTrip = "", this.widgetTripId = ""}) : super(key: key);

  @override
  _TripsState createState() => _TripsState();
}

class _TripsState extends State<Trips> {
  final authInstance = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  String trip = "";
  String tripId = "";

  String? username = "";

  @override
  void initState() {
    super.initState();
    trip = widget.widgetTrip;
    tripId = widget.widgetTripId;
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
          const ToolBar(title: "Trips"),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: TextField( // or using TextFormField and change initialValue
                controller: TextEditingController()..text = trip,
                decoration: const InputDecoration(hintText: "City name"),
                keyboardType: TextInputType.name,
                onChanged: (value){
                  trip = value;
                },
              )
            )
          ),
         Padding(
           padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
           child: MaterialButton(
               minWidth: double.infinity,
               color: Colors.lightBlue,
               child: const Text('Submit Trips', style: TextStyle(color: Colors.white)),
               onPressed: () async {
                 if (tripId != "") {
                    firestoreInstance.collection("Trips").doc(tripId).update({
                       "trip" : trip,
                       "username" : username,
                       "submitTime" : Timestamp.now()
                     }).then((value) => Navigator.pop(context));
                   } else {
                     firestoreInstance.collection("Trips").add({
                       "trip" : trip,
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