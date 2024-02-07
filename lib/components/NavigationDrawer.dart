import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
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
                    username!.substring(0, 1).toUpperCase(),
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
              // Navigate to profile
            },
          ),
          DrawerItem(
            icon: Icons.new_releases,
            title: 'Latest News',
            onTap: () {
              // Navigate to latest news
            },
          ),
          DrawerDivider(),
          DrawerItem(
            icon: Icons.bug_report,
            title: 'Bug Report',
            onTap: () {
              // Navigate to bug report
            },
          ),
          DrawerItem(
            icon: Icons.code,
            title: 'Developers',
            onTap: () {
              // Navigate to developers
            },
          ),
          DrawerDivider(),
          DrawerItem(
            icon: Icons.android,
            title: 'About app', onTap: () {},
            //onTap: _shareApp
          ),
          DrawerItem(
            icon: Icons.star_rate_rounded,
            title: 'Rate app', onTap: () {},
            //onTap: _rateApp
          ),
          DrawerItem(
            icon: Icons.share,
            title: 'Share app', onTap: () {},
            // onTap: () {
            //   comingSoon('About');
            // },
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
