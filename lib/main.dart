//import 'package:bus_flutter/breakdown_report.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lpg_gas_leakage/GasLevel.dart';
import 'package:lpg_gas_leakage/Guidelines.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LPG leakage detector',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  /* void _shareApp() {
    final RenderBox box = context.findRenderObject() as RenderBox;
    Share.share(
      'Check out the LPG leakage detector app!',
      subject: 'LPG leakage detector',
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // <-- add this line
      appBar: AppBar(
          title: Text(
            "LPG leakage detector",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black)),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/lpg.png',
                    height: 64,
                    width: 64,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'LPG leakage detector',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    'CodeMub',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text('Share app'),
              onTap: () {
                // TODO: Implement rate app functionality
              },
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Rate App'),
              onTap: () {
                // TODO: Implement rate app functionality
              },
            ),
            ListTile(
              leading: Icon(Icons.bug_report),
              title: Text('Report Bug'),
              onTap: () {
                // TODO: Implement report bug functionality
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(5.0),
            height: 230,
            child: CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 16 / 9,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                enlargeCenterPage: true,
              ),
              items: const [
                AssetImage('assets/lpg1.jpeg'),
                AssetImage('assets/lpg2.jpeg'),
                AssetImage('assets/lpg3.jpeg'),
                AssetImage('assets/lpg1.jpeg'),
              ].map((image) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Image(image: image),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 40),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            children: [
              _buildCard(Icons.gas_meter, 'GAS Level', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GasLevel()),
                );
              }),
              _buildCard(Icons.note_alt_sharp, 'Guidelines', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GuideLines()),
                );
              }),
              _buildCard(Icons.video_call, 'Videos', () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => IssuseForm()),
                // );
              }),
              _buildCard(Icons.report, 'Accident Report', () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => BusBreakdownReportForm()),
                // );
              }),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            backgroundColor: Color(0xFF070A52),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            backgroundColor: Color(0xFF070A52),
            label: 'About',
          ),
        ],
      ),
    );
  }

  Widget _buildCard(IconData iconData, String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 50,
            ),
            SizedBox(height: 16),
            Text(
              text,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
