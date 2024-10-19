import 'package:flutter/material.dart';

class BagScreen extends StatefulWidget {
  @override
  _BagScreenState createState() => _BagScreenState();
}

class _BagScreenState extends State<BagScreen> {
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
        child: Text('Welcome to the Bag Screen'),
      ),
    );
  }
}