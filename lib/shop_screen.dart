import 'package:flutter/material.dart';

class ShopScreen extends StatefulWidget {
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
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
        child: Text('Welcome to the Shop Screen'),
      ),
    );
  }
}