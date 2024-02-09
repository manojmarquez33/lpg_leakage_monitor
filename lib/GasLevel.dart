// import 'package:flutter/material.dart';
//
// class GasLevel extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           title: Text(
//             "Gas Leakage Level",
//             style: TextStyle(color: Colors.black),
//           ),
//           backgroundColor: Colors.white,
//           iconTheme: IconThemeData(color: Colors.black)),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Placeholder image for gas leakage
//             Image.asset(
//               'assets/lpg.png',
//               width: 200,
//               height: 100,
//               fit: BoxFit.contain,
//             ),
//             SizedBox(height: 20),
//             // Placeholder text for gas leakage values
//             Text(
//               'Gas Leakage Level: 3.5',
//               style: TextStyle(fontSize: 18),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// void main() {
//   runApp(MaterialApp(
//     home: GasLevel(),
//   ));
// }

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ThingSpeakDataPage extends StatefulWidget {
  @override
  _ThingSpeakDataPageState createState() => _ThingSpeakDataPageState();
}

class _ThingSpeakDataPageState extends State<ThingSpeakDataPage> {
  String lpgStatus = 'Loading...';
  Timer? timer;

  @override
  void initState() {
    super.initState();
    fetchData();
    // Start timer to refresh data every 3 seconds
    timer = Timer.periodic(Duration(seconds: 3), (Timer t) => fetchData());
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    timer?.cancel();
    super.dispose();
  }

  Future<void> fetchData() async {
    final String apiKey = 'BR0KM2NO9BUG9VFW';
    final String channelID = '2328482';
    final response = await http.get(
      Uri.parse(
          'https://api.thingspeak.com/channels/$channelID/fields/1.json?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Update the lpgStatus
      setState(() {
        lpgStatus = data['feeds'][0]['field2'].toString();
      });
    } else {
      // If there's an error fetching data, display an error message
      setState(() {
        lpgStatus = 'Error: Failed to load data';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ThingSpeak Data'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'LPG Status',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                lpgStatus,
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
