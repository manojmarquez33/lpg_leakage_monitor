import 'package:flutter/material.dart';

final Gradient appColor = LinearGradient(
  colors: [Color(0xFF38D39F), Color(0xFF27AE60)],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

class AboutAppPage extends StatefulWidget {
  @override
  _AboutAppPageState createState() => _AboutAppPageState();
}

class _AboutAppPageState extends State<AboutAppPage> {
  String _appName = 'LPG Gas Leakage';
  String _appVersion = '1.0.1';
  String _appIcon = 'assets/lpg.png';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Profile',
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 140),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Image.asset(_appIcon, width: 150, height: 150),
                ),
              ),
              SizedBox(height: 20),
              Text(
                _appName,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Version: $_appVersion',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
