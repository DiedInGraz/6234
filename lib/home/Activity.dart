import 'package:flutter/material.dart';
import 'package:cs6234/home/Toolbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cs6234/pages/Medicines.dart';

class Activity extends StatefulWidget {
  const Activity({Key? key}) : super(key: key);

  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  final firestoreInstance = FirebaseFirestore.instance;

  deleteActivities(String documentId) {
    firestoreInstance.collection("Medicines").doc(documentId).delete().then((value){
      print("Success!");
    });
  }

  showDetail() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("Medicines").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(!snapshot.hasData) {
          return Container(
            child: const Center(
              child: Text("Loading", style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.blue,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500
              ))
            )
          );
        } else {
          return ListView.builder(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              DocumentSnapshot ds = (snapshot.data!).docs[index];
              return Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),
                  child: Slidable(
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      dismissible: DismissiblePane(onDismissed: () {}),
                      children: [
                        SlidableAction(
                          // An action can be bigger than the others.
                          flex: 2,
                          onPressed: (_) {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Medicines(widgetMedicine: ds['medicine'], widgetMedicineId: ds.id)));
                          },
                          backgroundColor: Color(0xFF21B7CA),
                          foregroundColor: Colors.white,
                          icon: Icons.border_color,
                          label: 'Modify',
                        ),
                        SlidableAction(
                          // An action can be bigger than the others.
                          flex: 2,
                          onPressed: (_) {
                            deleteActivities(ds.id);
                          },
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5.0, 17.0, 5.0, 0.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(left: 12.0),
                                            child: RichText(
                                              text: TextSpan(
                                                  style: const TextStyle(
                                                      fontFamily: 'Poppins',
                                                      color: Colors.black,
                                                      fontSize: 15.0,
                                                      fontWeight: FontWeight.w400
                                                  ),
                                                  children: [
                                                    const TextSpan(text: "Medicine: "),
                                                    TextSpan(
                                                        text: ds['medicine'].toString(),
                                                        style: const TextStyle(
                                                            fontFamily: 'Poppins',
                                                            color: Colors.black,
                                                            fontSize: 15.0,
                                                            fontWeight: FontWeight.w700
                                                        )
                                                    )
                                                  ]
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                ],
                              ),
                            ),
                            Container(height: 16.0),
                          ],
                        )
                    ),
                  )
              );
            },
            itemCount: (snapshot.data!).docs.length,
            //padding: new EdgeInsets.symmetric(vertical: 4.0) // distance from bar to the first one
          );
        }
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const ToolBar(title: "Activities"),
          Expanded(
            child: showDetail()
          )
        ]
      )
    );
  }
}