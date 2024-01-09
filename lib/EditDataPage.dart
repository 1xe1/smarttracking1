import 'package:flutter/material.dart';
import 'package:smarttracking1/HealthData.dart';
import 'package:smarttracking1/menu_Screen.dart';
import 'package:http/http.dart' as http;
import 'package:smarttracking1/menu_health.dart';

class EditDataPage extends StatefulWidget {
  final Map<String, dynamic> data;

  EditDataPage({required this.data});

  @override
  _EditDataPageState createState() => _EditDataPageState();
}

class _EditDataPageState extends State<EditDataPage> {
  late TextEditingController docnoController;
  late TextEditingController dateController;
  late TextEditingController timeController;
  late TextEditingController valueController;

  @override
  void initState() {
    super.initState();
    docnoController =
        TextEditingController(text: widget.data['docno'].toString());
    dateController =
        TextEditingController(text: widget.data['date_log'].toString());
    timeController =
        TextEditingController(text: widget.data['time_log'].toString());
    valueController =
        TextEditingController(text: widget.data['data_value'].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: docnoController,
              decoration: InputDecoration(labelText: 'Docno'),
            ),
            TextFormField(
              controller: dateController,
              decoration: InputDecoration(labelText: 'Date'),
            ),
            TextFormField(
              controller: timeController,
              decoration: InputDecoration(labelText: 'Time'),
            ),
            TextFormField(
              controller: valueController,
              decoration: InputDecoration(labelText: 'Temperature'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Extracting updated data from controllers
                String updatedDocno = docnoController.text;
                String updatedDate = dateController.text;
                String updatedTime = timeController.text;
                String updatedValue = valueController.text;

                // API URL for the server
                String apiUrl =
                    'http://localhost:8081/tracking_API/healthSave.php';

                // Request body with updated data and case identifier
                Map<String, dynamic> requestBody = {
                  'docno': updatedDocno,
                  'docdate': updatedDate,
                  'time': updatedTime,
                  'value': updatedValue,
                  'case': 2,
                };

                try {
                  var response = await http.post(
                    Uri.parse(apiUrl),
                    body: requestBody,
                  );

                  // Handle response based on HTTP status code
                  if (response.statusCode == 200) {
                    showSuccessDialog(context, "Data saved successfully");
                  } else {
                    showSuccessDialog(context, "Unable to save data");
                  }
                } catch (error) {
                  showSuccessDialog(
                      context, 'Error connecting to the server: $error');
                }
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    docnoController.dispose();
    dateController.dispose();
    timeController.dispose();
    valueController.dispose();
    super.dispose();
  }

  void showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => MenuHealthScreen(),
                  ),
                );
              },
              child: Text('Go to Health Menu'),
            ),
          ],
        );
      },
    );
  }
}
