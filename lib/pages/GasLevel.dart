import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:vibration/vibration.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GasLevel(),
    );
  }
}

class GasLevel extends StatefulWidget {
  @override
  _GasLevelState createState() => _GasLevelState();
}

class _GasLevelState extends State<GasLevel> {
  String lpgStatus = 'Loading...';
  String test = "number";
  StreamController<Map<String, String>> _dataStreamController = StreamController<Map<String, String>>();
  Timer? timer;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();

    // Initialize notifications
    initializeNotifications();

    // Initialize background tasks
    Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: false,
    );
    Workmanager().registerPeriodicTask(
      "gasLevelTask",
      "fetchDataPeriodically",
      frequency: Duration(minutes: 15), // Adjust the frequency as needed
    );

    fetchData();
    // Start timer to refresh data every 3 seconds
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => fetchData());
  }

  void initializeNotifications() async {
    var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    //var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      //iOS: initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  static void callbackDispatcher() {
    Workmanager().executeTask((task, inputData) async {
      await fetchDataPeriodically();
      return Future.value(true);
    });
  }

  static Future<void> fetchDataPeriodically() async {
    // Implement the periodic data fetching logic here
    // You can reuse the fetchData() logic here
  }

  @override
  void dispose() {
    // Cancel the timer and close the stream when the widget is disposed
    timer?.cancel();
    _dataStreamController.close();
    super.dispose();
  }

  Future<void> fetchData() async {
    final String apiKey = 'KYDUN9EO2LP079QO';
    final String channelID = '2328482';
    final response = await http.get(
      Uri.parse('https://api.thingspeak.com/channels/2328482/feeds.json?api_key=UQQTQ7S59CG81PNP&results=2'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Emit new data through the stream
      _dataStreamController.add({
        'lpgStatus': data['feeds'][0]['field1']?.toString() ?? 'Field1 not available',
        'test': data['feeds'][0]['field2']?.toString() ?? 'Field2 not available',
      });

      // Check if gas level is greater than 50 and send notification
      double gasLevel = double.tryParse(data['feeds'][0]['field1']?.toString() ?? '0.0') ?? 0.0;
      if (gasLevel > 50) {
        sendNotification("Gas leakage occurred", "Gas level is greater than 50");
        vibratePhone();
      }
    } else {
      // If there's an error fetching data, display an error message
      _dataStreamController.add({
        'lpgStatus': 'Error: Failed to load data',
        'test': 'Error',
      });
    }
  }

  void sendNotification(String title, String body) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
     // 'channel_description',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      vibrationPattern: Int64List.fromList([0, 500, 1000, 500, 1000, 500, 1000, 500, 1000]),
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  void vibratePhone() {
    // Vibrate the phone
    // Note: This may not work on all devices
    // Check for vibration support on the device
    Vibration.vibrate(duration: 2000);
  }

  Widget getImageBasedOnLevel(String lpgStatus) {
    double gasLevel = double.tryParse(lpgStatus) ?? 0.0;

    if (gasLevel <= 50) {
      return Image.asset(
        'assets/lpg.png',
        width: 200,
        height: 100,
        fit: BoxFit.contain,
      );
    } else {
      return Image.asset(
        'assets/lpg_burst.png',
        width: 200,
        height: 100,
        fit: BoxFit.contain,
      );
    }
  }

  Widget buildLoadingShimmer() {
    return Center(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.white,
              width: 200,
              height: 10,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.white,
                  width: 150,
                  height: 10,
                ),
                SizedBox(width: 10),
                Container(
                  color: Colors.white,
                  width: 30,
                  height: 10,
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              color: Colors.white,
              width: 150,
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Gas Level',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF4285F4),
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: StreamBuilder<Map<String, String>>(
            stream: _dataStreamController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // Use the latest data to update the UI
                lpgStatus = snapshot.data!['lpgStatus'] ?? 'Loading...';
                test = snapshot.data!['test'] ?? 'number';

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Gas Leakage Status',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    lpgStatus == 'Loading...'
                        ? buildLoadingShimmer()
                        : getImageBasedOnLevel(lpgStatus),
                    SizedBox(height: 20),
                    lpgStatus == 'Loading...'
                        ? buildLoadingShimmer()
                        : Text(
                      'Status: $lpgStatus',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    lpgStatus == 'Loading...'
                        ? buildLoadingShimmer()
                        : SizedBox(height: 10),
                    lpgStatus == 'Loading...'
                        ? buildLoadingShimmer()
                        : Text(
                      'Level: $test',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                // Handle error case
                return Text('Error: ${snapshot.error}');
              } else {
                // Display a loading shimmer if no data is available yet
                return buildLoadingShimmer();
              }
            },
          ),
        ),
      ),
    );
  }
}
