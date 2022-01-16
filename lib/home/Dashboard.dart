import 'package:flutter/material.dart';
import 'package:cs6234/home/Toolbar.dart';
import 'package:cs6234/model/FunctionalityCard.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const ToolBar(title: "Dashboard"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text("Get Covid Possibility is N/A", style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.lightBlueAccent,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w600
                )),
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              childAspectRatio: 0.9, // default
              padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 5.0),
              crossAxisSpacing: 10,
              mainAxisSpacing: 15,
              crossAxisCount: 2,
              physics: const ScrollPhysics(),
              children: const <Widget>[
                FunctionalityCard(
                  functionality: "Symptom",
                  icon: Icons.announcement,
                ),
                FunctionalityCard(
                  functionality: "Medicines",
                  icon: Icons.medication,
                ),
                FunctionalityCard(
                  functionality: "Doctor Visit",
                  icon: Icons.medical_services,
                ),
                FunctionalityCard(
                  functionality: "Trip",
                  icon: Icons.beach_access,
                ),
                FunctionalityCard(
                  functionality: "News",
                  icon: Icons.new_releases,
                ),
                FunctionalityCard(
                  functionality: "Take Out Food",
                  icon: Icons.food_bank,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}