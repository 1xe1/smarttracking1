import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HealthDataPage extends StatefulWidget {
  @override
  _HealthDataPageState createState() => _HealthDataPageState();
}

class _HealthDataPageState extends State<HealthDataPage> {
  late Future<List<Map<String, dynamic>>> _healthData;

  Future<List<Map<String, dynamic>>> _fetchHealthData() async {
    final response = await http
        .get(Uri.parse('http://localhost:8081/tracking_API/selecthealth.php'));
    print(response.statusCode);
    if (response.statusCode == 200) {
      final List<dynamic> parsed = json.decode(response.body);
      return parsed.cast<Map<String, dynamic>>();
    } else {
      throw Exception('ไม่สามารถเชื่อมต่อข้อมูลได้ กรุณาตรวจสอบ');
    }
  }

  @override
  void initState() {
    super.initState();
    _healthData = _fetchHealthData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen.shade400,
        leading: IconButton(
          icon: Icon(Icons.home_outlined),
          color: Colors.red,
          onPressed: () {},
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Body Health',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _healthData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('ไม่พบข้อมูล'));
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/dt.png',
                      width: 40,
                      height: 40,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Body Health',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: <DataColumn>[
                        DataColumn(label: Text(' ')),
                        DataColumn(label: Text('Name')),
                        DataColumn(label: Text('Surname')),
                        DataColumn(label: Text('Temp.')),
                        DataColumn(label: Text('Edit')),
                      ],
                      rows: snapshot.data!.map((data) {
                        return DataRow(
                          cells: <DataCell>[
                            DataCell(Text(' ')),
                            DataCell(Text(data['firstname'].toString())),
                            DataCell(Text(data['lastname'].toString())),
                            DataCell(Text(data['heart_value'].toString())),
                            DataCell(IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                // Navigate to the edit page with the selected data
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EditHealthDataPage(data: data),
                                  ),
                                );
                              },
                            )),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class EditHealthDataPage extends StatefulWidget {
  final Map<String, dynamic> data;

  EditHealthDataPage({required this.data});

  @override
  _EditHealthDataPageState createState() => _EditHealthDataPageState();
}

class _EditHealthDataPageState extends State<EditHealthDataPage> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController heartValueController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing data
    firstNameController = TextEditingController(text: widget.data['firstname'].toString());
    lastNameController = TextEditingController(text: widget.data['lastname'].toString());
    heartValueController = TextEditingController(text: widget.data['heart_value'].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Health Data'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Edit Health Data for ${widget.data['firstname']}'),
            SizedBox(height: 20),
            TextFormField(
              controller: firstNameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            TextFormField(
              controller: lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            TextFormField(
              controller: heartValueController,
              decoration: InputDecoration(labelText: 'Heart Value'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Get the updated values from the text controllers
                String updatedFirstName = firstNameController.text;
                String updatedLastName = lastNameController.text;
                String updatedHeartValue = heartValueController.text;

                // TODO: Implement logic to save the edited data
                // You can use the updated values to make an API request to update the data on the server

                // For now, print the updated values
                print('Updated First Name: $updatedFirstName');
                print('Updated Last Name: $updatedLastName');
                print('Updated Heart Value: $updatedHeartValue');

                // Close the edit page
                Navigator.pop(context);
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    heartValueController.dispose();
    super.dispose();
  }
}

void main() {
  runApp(MaterialApp(
    home: HealthDataPage(),
  ));
}
