import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
        child: Text('Welcome to the Profile Screen'),
      ),
    );
  }
}