import 'package:cms_customer/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme/theme.dart';
import '../theme/theme_notifier.dart';
import 'change_pin.dart';
import 'feedback.dart';
import 'login.dart';

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
      appBar: AppBar(
        title: Text('Menu'),
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
          if (menuItem.icon == Icons.person) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Profile()),
            );
          }
          if (menuItem.icon == Icons.palette) {
            _showThemeDialog(context);
          }if (menuItem.icon == Icons.logout) {
            _showLoginDialog(context);
          }if (menuItem.icon == Icons.star_rate) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RatingScreen()),
            );
          }if (menuItem.icon == Icons.phonelink_lock) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChangeMPin()),
            );
          }
          else if (menuItem.icon == Icons.share) {
            _shareAppLink();
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
                title: Text('Dark'),
                onTap: () {
                  themeNotifier.setTheme(AppThemes.darkTheme);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('Light'),
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
  void _showLoginDialog(BuildContext context) {

    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      width: 350,
      body: StatefulBuilder(
        builder: (context, setState) {
          return Container(
              padding: EdgeInsets.all(20),
              child: Text("Are you sure want to Log out",style: Theme.of(context).textTheme.bodySmall,));
        },
      ),
      btnOk: ElevatedButton(
        onPressed: () async {
          // SharedPreferences prefs =
          // await SharedPreferences.getInstance();
          // await prefs.setBool('isLoggedIn', false);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
          // Handle OK button press
        },
        style: ButtonStyle(
          backgroundColor:
          MaterialStateProperty.all<Color>(Colors.green),
        ),
        child: const Text(
          'Yes',
          style: TextStyle(color: Colors.white),
        ),
      ),
      btnCancel: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop(); // Close the dialog
        },
        style: ButtonStyle(
          backgroundColor:
          MaterialStateProperty.all<Color>(Colors.red),
        ),
        child: Text(
          'No',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ).show();
  }
  void _shareAppLink() {
    final String appLink = 'https://yourappurl.com'; // Replace with your app's link
    Share.share('Check out this app: $appLink');
  }
}