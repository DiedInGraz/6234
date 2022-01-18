import 'package:flutter/material.dart';
import 'package:cs6234/home/Toolbar.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF3366FF), // blue: 0xFF3366FF; purple: 0xFF9400D3; green: 0xFF3CB371
              Color(0xFF00CCFF)
            ],
          ),
        ),
        child: ListView(
          //crossAxisAlignment: CrossAxisAlignment.start,
          padding: const EdgeInsets.symmetric(horizontal: 30.0).copyWith(top: 140.0),
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  const Text("Sign In", style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.lightBlueAccent,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w600
                  )),
                  Container(height: 20.0),
                  TextField(
                    decoration: const InputDecoration(hintText: "Email Address"),
                    onChanged: (value){

                    },
                  ),
                  Container(height: 20.0),
                  TextField(
                    decoration: const InputDecoration(hintText: "Password"),
                    onChanged: (value){

                    },
                  ),
                  Container(height: 20.0),
                  MaterialButton(
                    minWidth: double.infinity,
                    color: Colors.lightBlue,
                    child: const Text('Login', style: TextStyle(color: Colors.white)),
                    onPressed: () async {

                    }
                  )
                ],
              )
            ),

          ],
        ),
      ),
    );
  }
}