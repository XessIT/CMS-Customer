import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/theme.dart';
import '../theme/theme_notifier.dart';

class MenuScreen extends StatelessWidget {
  final List<MenuItem> menuItems = [
    MenuItem(icon: Icons.person, title: 'My Profile'),
    MenuItem(icon: Icons.contact_mail, title: 'Contact us'),
    MenuItem(icon: Icons.phonelink_lock, title: 'Change password'),
    MenuItem(icon: Icons.palette, title: 'Theme'),
    MenuItem(icon: Icons.share, title: 'Share'),
    MenuItem(icon: Icons.star_rate, title: 'Rate'),
    MenuItem(icon: Icons.logout, title: 'Logout'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFF3F5FD),

      appBar: AppBar(
        //backgroundColor: Color(0xFF22538D),
        backgroundColor: Color(0xFFFFD188),

        title: Text('Menu', style: TextStyle(color: Colors.black)),
      ),
      body: ListView.builder(
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          return MenuItemTile(menuItem: menuItems[index]);
        },
      ),
    );
  }
}

class MenuItem {
  final IconData icon;
  final String title;

  MenuItem({required this.icon, required this.title});
}

class MenuItemTile extends StatelessWidget {
  final MenuItem menuItem;

  MenuItemTile({required this.menuItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Icon(menuItem.icon, color: Colors.blue),
        title: Text(menuItem.title),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
        tileColor: Colors.white,
        onTap: () {
          if (menuItem.icon == Icons.palette) {
           // _showThemeDialog(context);
          }
          // Handle menu item tap
        },
      ),
    );
  }
  void _showThemeDialog(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose Theme'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Dark Blue'),
                onTap: () {
                  themeNotifier.setTheme(AppThemes.darkTheme);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('Light Orange'),
                onTap: () {
                  themeNotifier.setTheme(AppThemes.lightTheme);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}