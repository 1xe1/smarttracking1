import 'package:flutter/material.dart';
import 'healthSave.dart'; // Import your HealthSaveScreen file
import 'healthData.dart'; // Import your HealthDataPage file

class MenuHealthScreen extends StatelessWidget {
  final List<String> imagePaths = [
    'images/heart.png',
    'images/fever.png',
    'images/blood-pressure.png',
    'images/sleep.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Menu'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          childAspectRatio: 1.0,
        ),
        itemCount: imagePaths.length + 1, // Add 1 for the HealthData button
        itemBuilder: (context, index) {
          if (index < imagePaths.length) {
            return GestureDetector(
              onTap: () {
                // Navigate to HealthSaveScreen when the image is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HealthSaveScreen()),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Image.asset(
                    imagePaths[index],
                    width: 100.0,
                    height: 100.0,
                  ),
                ),
              ),
            );
          } else {
            // HealthData button
            return GestureDetector(
              onTap: () {
                // Navigate to HealthDataPage when the button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HealthDataPage()),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Text(
                    'Health Data',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
