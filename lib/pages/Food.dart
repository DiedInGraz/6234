import 'package:flutter/material.dart';
import 'package:cs6234/home/Toolbar.dart';

class Food extends StatefulWidget {
  const Food({Key? key}) : super(key: key);

  @override
  _FoodState createState() => _FoodState();
}

class _FoodState extends State<Food> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          ToolBar(title: "Food")
        ]
      )
    );
  }
}