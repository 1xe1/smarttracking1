import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextEditingController _imeiController = TextEditingController();
  TextEditingController _deviceNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _imeiController,
              decoration: InputDecoration(labelText: 'IMEI Number'),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              controller: _deviceNameController,
              decoration: InputDecoration(labelText: 'Device Name'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                // Get values from text controllers
                String newImei = _imeiController.text;
                String newDeviceName = _deviceNameController.text;

                // Call API to update settings
                await updateSettings(newImei, newDeviceName);

                // Navigate back to menu after successful update
                Navigator.pop(context);
              },
              child: Text('Update Settings'),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(200, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateSettings(String imei, String deviceName) async {
    // Replace with your API endpoint
    final apiUrl = 'http://localhost:8081/tracking_API/setting.php';

    try {
      // Make a POST request to update settings
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'imei_no': imei,
          'device_name': deviceName,
        },
      );

      if (response.statusCode == 200) {
        // Handle successful update
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Settings updated successfully')),
        );
      } else {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update settings')),
        );
      }
    } catch (e) {
      // Handle exceptions
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error occurred while updating settings')),
      );
    }
  }
}
