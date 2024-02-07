import 'package:flutter/material.dart';

class GasLevel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Gas Leakage Level",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Placeholder image for gas leakage
            Image.asset(
              'assets/lpg.png',
              width: 200,
              height: 100,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 20),
            // Placeholder text for gas leakage values
            Text(
              'Gas Leakage Level: 3.5',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: GasLevel(),
  ));
}
