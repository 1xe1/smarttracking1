import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import services for FilteringTextInputFormatter
import 'package:http/http.dart' as http;

class HealthSaveScreen extends StatefulWidget {
  @override
  _HealthSaveScreenState createState() => _HealthSaveScreenState();
}

class _HealthSaveScreenState extends State<HealthSaveScreen> {
  TextEditingController _idCardController = TextEditingController();
  TextEditingController _titlenameController = TextEditingController();
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _heartValueController = TextEditingController();
  TextEditingController _pulseValueController = TextEditingController();

  // Function to show date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != DateTime.now()) {
      // Format the selected date and update the controller
      String formattedDate = "${picked.day}/${picked.month}/${picked.year}";
      _dobController.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Save Health Data'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _idCardController,
              decoration: InputDecoration(labelText: 'ID Card'),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              controller: _titlenameController,
              decoration: InputDecoration(labelText: 'Title Name'),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              controller: _firstnameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              controller: _lastnameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              controller: _dobController,
              onTap: () {
                // Show date picker when the Date of Birth field is tapped
                _selectDate(context);
              },
              readOnly: true, // Make the text field read-only
              decoration: InputDecoration(labelText: 'Date of Birth'),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              controller: _heartValueController,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly, // Allow digits only
              ],
              decoration: InputDecoration(labelText: 'Heart Value'),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              controller: _pulseValueController,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly, // Allow digits only
              ],
              decoration: InputDecoration(labelText: 'Pulse Value'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                // Get values from text controllers
                String idCard = _idCardController.text;
                String titlename = _titlenameController.text;
                String firstname = _firstnameController.text;
                String lastname = _lastnameController.text;
                String dob = _dobController.text;
                String heartValue = _heartValueController.text;
                String pulseValue = _pulseValueController.text;

                // Call API to save health data
                await saveHealthData(idCard, titlename, firstname, lastname,
                    dob, heartValue, pulseValue);

                // Navigate back to previous screen after successful save
                Navigator.pop(context);
              },
              child: Text('Save Health Data'),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(200, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveHealthData(String idCard, String titlename, String firstname,
      String lastname, String dob, String heartValue, String pulseValue) async {
    // Replace with your API endpoint
    final apiUrl = 'http://localhost:8081/tracking_API/healthSave.php';

    try {
      // Make a POST request to save health data
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'id_card': idCard,
          'titlename': titlename,
          'firstname': firstname,
          'lastname': lastname,
          'date_of_birth': dob,
          'heart_value': heartValue,
          'pulse_value': pulseValue,
        },
      );

      if (response.statusCode == 200) {
        // Handle successful save
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Health data saved successfully')),
        );
      } else {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save health data')),
        );
      }
    } catch (e) {
      // Handle exceptions
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error occurred while saving health data')),
      );
    }
  }
}
