import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class AccidentReport extends StatefulWidget {
  const AccidentReport({Key? key}) : super(key: key);

  @override
  _AccidentReportState createState() => _AccidentReportState();
}

class _AccidentReportState extends State<AccidentReport> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _accidentTimeController = TextEditingController();
  final TextEditingController _causeController = TextEditingController();
  final TextEditingController _casualtiesCountController =
      TextEditingController();
  final TextEditingController _remedyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Accident Report',
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
        ),
        backgroundColor:Color(0xFF4285F4),
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  _buildTextField('Name', Icons.person, _nameController),
                  _buildTextField(
                      'Address', Icons.location_on, _addressController),
                  _buildTextField('City', Icons.location_city, _cityController),
                  _buildTextField(
                      'State', Icons.location_city, _stateController),
                  _buildTextField('Accident Time', Icons.access_time,
                      _accidentTimeController),
                  _buildTextField('Cause', Icons.warning, _causeController),
                  _buildTextField('Casualties Count', Icons.people,
                      _casualtiesCountController),
                  _buildTextField('Remedy', Icons.healing, _remedyController),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      sendDataToBackend();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF4285F4)),
                      elevation: MaterialStateProperty.all<double>(8.0),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, IconData icon, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }

  void sendDataToBackend() async {
    if (_formKey.currentState?.validate() ?? false) {
      final url = 'https://kcetmap.000webhostapp.com/report.php';

      try {
        final response = await http.post(
          Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'name': _nameController.text,
            'address': _addressController.text,
            'city': _cityController.text,
            'state': _stateController.text,
            'accidentTime': _accidentTimeController.text,
            'cause': _causeController.text,
            'casualtiesCount': _casualtiesCountController.text,
            'remedy': _remedyController.text,
          }),
        );

        if (response.statusCode == 200) {
          Fluttertoast.showToast(
            msg: 'Data sent successfully!',
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );

          _nameController.clear();
          _addressController.clear();
          _cityController.clear();
          _stateController.clear();
          _accidentTimeController.clear();
          _causeController.clear();
          _casualtiesCountController.clear();
          _remedyController.clear();
        } else {
          // Show error toast
          Fluttertoast.showToast(
            msg: 'Failed to send data. Try again later.',
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        }
      } catch (e) {
        // Show error toast
        Fluttertoast.showToast(
          msg: 'Error sending data. Try again later.',
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    }
  }
}
