import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "me",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Text(
        "Welcome",
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
