import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
        backgroundColor: Colors.green, // Màu của AppBar
      ),
      // appBar: AppBar(
      //   title: Text('Setting'),
      //   backgroundColor: Colors.green, // Màu của AppBar
      // ),
      body: Center(
        child: Text('Welcome to the Home Screen'),
      ),
    );
  }
}