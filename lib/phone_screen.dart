import 'package:flutter/material.dart';

class PhoneScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'images/call.png', // Adjust the path accordingly
              width: 200.0, // Adjust the width as needed
              height: 200.0, // Adjust the height as needed
            ),
            SizedBox(height: 16.0),
            Text(
              'Emergency Call',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
