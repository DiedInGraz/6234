import 'package:flutter/material.dart';
import 'package:cs6234/home/Toolbar.dart';
import 'package:health/health.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cs6234/auth/SignIn.dart';
import 'package:cs6234/auth/TestImage.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {

  final authInstance = FirebaseAuth.instance;
  HealthFactory health = HealthFactory();

  List<HealthDataPoint> _healthDataList = [];
  num totalSteps = 0;
  num totalDistance = 0;

  String? username = "";

  @override
  void initState() {
    super.initState();
    final currentUser = authInstance.currentUser;
    if (currentUser != null) {
      print(currentUser);
      username = currentUser.email;
      print("here");
    } else {
      print(currentUser);
      print("not login");
    }
  }

  ListView _contentDataReady() {
    return ListView.builder(
        itemCount: _healthDataList.length,
        itemBuilder: (_, index) {
          HealthDataPoint p = _healthDataList[index];
          return ListTile(
            title: Text("${p.typeString}: ${p.value}"),
            trailing: Text('${p.unitString}'),
            subtitle: Text('${p.dateFrom} - ${p.dateTo}'),
          );
        });
  }

  Future fetchData() async {
    final types = [
      HealthDataType.STEPS,
      HealthDataType.DISTANCE_WALKING_RUNNING,
    ];

    final permissions = [
      HealthDataAccess.READ,
      HealthDataAccess.READ,
    ];

    final now = DateTime.now();
    final yesterday = now.subtract(Duration(days: 1));
    final beginning = DateTime(now.year, now.month, now.day);


    bool requested = await health.requestAuthorization(types, permissions: permissions);

    if (requested) {
      try {
        List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(beginning, now, types);
        totalSteps = 0;
        totalDistance = 0;
        setState(() {
          for(int i = 0; i < healthData.length; i++) {
            if(healthData[i].typeString == "STEPS") {
              totalSteps += healthData[i].value;
            }
            if(healthData[i].typeString == "DISTANCE_WALKING_RUNNING") {
              totalDistance += healthData[i].value;
            }
          }
          totalDistance = totalDistance.roundToDouble();
        });


        //print(healthData);
        _healthDataList.addAll((healthData.length < 100)
            ? healthData
            : healthData.sublist(0, 100));
      } catch (error) {
        print("Exception in getHealthDataFromTypes: $error");
      }

      _healthDataList = HealthFactory.removeDuplicates(_healthDataList);

    } else {
      print("Authorization not granted");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const ToolBar(title: "Account"),
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
          //   child: MaterialButton(
          //     //minWidth: double.infinity,
          //       color: Colors.lightBlue,
          //       child: const Text('Testing login authentication', style: TextStyle(color: Colors.white)),
          //       onPressed: () {
          //         Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignIn()));
          //       }
          //   ),
          // ),
          const Padding(
            padding: EdgeInsets.fromLTRB(50, 35, 50, 5),
            child: Text("Welcome", style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.lightBlue,
                fontSize: 30.0,
                fontWeight: FontWeight.w600
            )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 15, 30, 5),
            child: Text(username!, style: const TextStyle(
                fontFamily: 'Poppins',
                color: Colors.lightBlue,
                fontSize: 25.0,
                fontWeight: FontWeight.w700
            )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
            child: MaterialButton(
              //minWidth: double.infinity,
                color: Colors.lightBlue,
                child: const Text('Log Out', style: TextStyle(color: Colors.white)),
                onPressed: () async {
                  await authInstance.signOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const SignIn()));
                }
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
            child: MaterialButton(
              //minWidth: double.infinity,
                color: Colors.lightBlue,
                child: const Text('Test Image Delete Later (Somehow logout. Need to click log out and login back again)', style: TextStyle(color: Colors.white)),
                onPressed: () async {
                  await authInstance.signOut();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TestPage()));
                }
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
            child: MaterialButton(
                //minWidth: double.infinity,
                color: Colors.lightBlue,
                child: const Text('Sync Data from Apple Health', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  fetchData();
                }
            ),
          ),
          Text("Today step is: " + totalSteps.toString(), style: const TextStyle(
              fontFamily: 'Poppins',
              color: Colors.lightBlueAccent,
              fontSize: 25.0,
              fontWeight: FontWeight.w600
          )),
          Text("Today distance in meter is: " + totalDistance.toString(), style: const TextStyle(
              fontFamily: 'Poppins',
              color: Colors.lightBlueAccent,
              fontSize: 25.0,
              fontWeight: FontWeight.w600
          )),
          //Expanded(child: _contentDataReady())

        ]
      )
    );
  }
}