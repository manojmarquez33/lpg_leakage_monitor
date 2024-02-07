import 'package:flutter/material.dart';

class SideNavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
          DrawerItem(
              icon: Icons.share,
              title: 'Share App',
              onTap: () {
                // TODO: Implement share app functionality
              }),
          DrawerItem(
              icon: Icons.star,
              title: 'Rate App',
              onTap: () {
                // TODO: Implement rate app functionality
              }),
          DrawerItem(
              icon: Icons.bug_report,
              title: 'Report Bug',
              onTap: () {
                // TODO: Implement report bug functionality
              }),
          DrawerDivider(),
          DrawerItem(
              icon: Icons.person,
              title: 'Profile',
              onTap: () {
                // TODO: Implement profile functionality
              }),
          DrawerItem(
              icon: Icons.new_releases,
              title: 'Latest News',
              onTap: () {
                // TODO: Implement latest news functionality
              }),
          DrawerItem(
              icon: Icons.update,
              title: 'Check for Update',
              onTap: () {
                // TODO: Implement check for update functionality
              }),
          DrawerDivider(),
          DrawerItem(
              icon: Icons.more_horiz,
              title: 'More',
              onTap: () {
                // TODO: Implement additional menu functionality
              }),
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
      leading: Icon(icon),
      title: Text(title),
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
