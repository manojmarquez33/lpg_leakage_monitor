import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lpg_gas_leakage/components/NavigationDrawer.dart';
import 'package:lpg_gas_leakage/pages/AccidentReport.dart';
import 'package:lpg_gas_leakage/pages/GasLevel.dart';
import 'package:lpg_gas_leakage/pages/Guidelines.dart';
import 'package:lpg_gas_leakage/pages/VideoHelp.dart';
import 'package:lpg_gas_leakage/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? username = prefs.getString('username');

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: username != null ? HomePage() : LoginScreen(),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LPG Leakage Detector',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'LPG Leakage Monitor',
          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
        ),
        // backgroundColor:Color(0xFF4285F4),
        backgroundColor:Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      drawer: SideNavigationDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(3.0),
              height: 230,
              child: CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 16 / 9,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  enlargeCenterPage: true,
                ),
                items: const [
                  'assets/lpg1.jpeg',
                  'assets/lpg2.jpeg',
                  'assets/lpg3.jpeg',
                  'assets/lpg1.jpeg',
                ].map((imagePath) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.asset(
                            imagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
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
                _buildCard('assets/level.png', 'GAS Level', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GasLevel()),
                  );
                }),
                _buildCard('assets/compliant.png', 'Guidelines', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GuideLines()),
                  );
                }),
                _buildCard('assets/refer.png', 'Videos', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VideoListScreen()),
                  );
                }),
                _buildCard('assets/fire.png', 'Accident Report', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AccidentReport()),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            indicatorColor: Color(0xFF94e5ff),
            labelTextStyle: MaterialStateProperty.all(
                TextStyle(fontSize: 14, fontWeight: FontWeight.w500))),
        child: NavigationBar(
          height: 75,
          backgroundColor: Color(0xFFf1f5fb),
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) =>
              setState(() => this._selectedIndex = index),
          destinations: [
            NavigationDestination(
                icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(
                icon: Icon(Icons.call), label: 'Emergency'),
            NavigationDestination(
                icon: Icon(Icons.person), label: 'About'),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String imagePath, String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              text,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
