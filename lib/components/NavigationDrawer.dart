import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:lpg_gas_leakage/NavBarMenus/profile.dart';
import 'package:lpg_gas_leakage/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SideNavigationDrawer extends StatefulWidget {
  @override
  _SideNavigationDrawerState createState() => _SideNavigationDrawerState();
}

class _SideNavigationDrawerState extends State<SideNavigationDrawer> {
  String username = ''; // Variable to store the fetched username

  @override
  void initState() {
    super.initState();
    fetchUsername(); // Fetch username when the widget is initialized
  }

  Future<void> fetchUsername() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      username = prefs.getString('username') ??
          ''; // Fetch username from SharedPreferences
    });

    final apiUrl =
        'https://kcetmap.000webhostapp.com/login.php?username=$username';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        // Assuming the response contains the username in plain text
        // Handle the API response here
        print('API Response: ${response.body}');
      } else {
        // Handle errors here
        print('Failed to fetch username. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions here
      print('Error fetching username: $e');
    }
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void comingSoon(String message) {
    Fluttertoast.showToast(
      msg: "Coming Soon",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.black54,
    );
  }

  void _shareApp() async {
    String playStoreUrl =
        'https://play.google.com/store/apps/details?id=com.kcet.canteen';

    await _launchURL(playStoreUrl);
  }

  void _rateApp() {
    String playStoreUrl =
        'https://play.google.com/store/apps/details?id=com.kcet.canteen';

    _launchURL(playStoreUrl);
  }

  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
    setState(() {
      username = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
            color: Color(0xFF4285F4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.0),
                CircleAvatar(
                  child: Text(
                    username.isNotEmpty
                        ? username.substring(0, 1).toUpperCase()
                        : '',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4285F4),
                    ),
                  ),
                  radius: 40.0,
                  backgroundColor: Colors.white,
                ),
                SizedBox(height: 10.0),
                Text(
                  username!,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5.0),
              ],
            ),
          ),
          DrawerItem(
            icon: Icons.person,
            title: 'Profile',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
          DrawerItem(
            icon: Icons.new_releases,
            title: 'Latest News',
            onTap: () {
              comingSoon('Latest News');
            },
          ),
          DrawerDivider(),
          DrawerItem(
            icon: Icons.bug_report,
            title: 'Bug Report',
            onTap: () {
              comingSoon('Bug Report');
            },
          ),
          DrawerItem(
            icon: Icons.code,
            title: 'Developers',
            onTap: () {
              comingSoon('Developers');
            },
          ),
          DrawerDivider(),
          DrawerItem(
            icon: Icons.android,
            title: 'About app',
            onTap: () {
              comingSoon('About app');
            },
          ),
          DrawerItem(
            icon: Icons.star_rate_rounded,
            title: 'Rate app',
            onTap: () {
              comingSoon('About app');
            },
            //onTap: _rateApp
          ),
          DrawerItem(
            icon: Icons.share,
            title: 'Share app',
            onTap: () {
              comingSoon('Share app');
            },
          ),
          DrawerDivider(),
          DrawerItem(
            icon: Icons.logout,
            title: 'Log out',
            onTap: _logout,
          ),
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const DrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.black87,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black87,
        ),
      ),
      onTap: onTap,
    );
  }
}

class DrawerDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider();
  }
}
