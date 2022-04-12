import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cs6234/home/Toolbar.dart';
import 'package:intl/intl.dart';

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
  TextEditingController dateinput = TextEditingController();
  String trip = "";
  String tripId = "";
  String? username = "";
  String formattedDate_1 = "";
  String formattedDate_2 ="";


  @override
  void initState() {
    dateinput.text = "";
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
         Container (
           padding: EdgeInsets.all(15),
           height: 150,
           child:Center(
               child:TextField(
                 controller: dateinput,
                 decoration: InputDecoration(
                     icon: Icon(Icons.calendar_today),
                     labelText: "Enter Start Date"
                   ),
                   readOnly: true,
                   onTap: () async{
                    DateTime? pickedDate = await showDatePicker(
                     context: context, initialDate: DateTime.now(),
                     firstDate: DateTime(2000),
                     lastDate: DateTime(2101)
                   );

                   if(pickedDate != null){
                     print(pickedDate);
                     formattedDate_1 = DateFormat('yyyy-MM-dd').format(pickedDate);
                     print(formattedDate_1);

                     setState(() {
                       dateinput.text = formattedDate_1;
                     });
                   }else{
                     print("Date is not selected");
                   }
                 },
             )
           )
         ),
         Container (
             padding: EdgeInsets.all(15),
             height: 150,
             child:Center(
                 child:TextField(
                   controller: dateinput,
                   decoration: InputDecoration(
                       icon: Icon(Icons.calendar_today),
                       labelText: "Enter End Date"
                    ),
                    readOnly: true,
                    onTap: () async{
                      DateTime? pickedDate = await showDatePicker(
                          context: context, initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101)
                      );

                     if(pickedDate != null){
                       print(pickedDate);
                       formattedDate_2 = DateFormat('yyyy-MM-dd').format(pickedDate);
                       print(formattedDate_2);

                       setState(() {
                         dateinput.text = formattedDate_2;
                       });
                     }else{
                       print("Date is not selected");
                     }
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
                       "submitTime" : Timestamp.now(),
                       "startTime": formattedDate_1,
                       "endTime": formattedDate_2
                     }).then((value) => Navigator.pop(context));
                   } else {
                     firestoreInstance.collection("Trips").add({
                       "trip" : trip,
                       "username" : username,
                       "submitTime" : Timestamp.now(),
                       "startTime": formattedDate_1,
                       "endTime": formattedDate_2
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