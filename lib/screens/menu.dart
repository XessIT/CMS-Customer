import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  final List<MenuItem> menuItems = [
    MenuItem(icon: Icons.person, title: 'My Profile'),
    MenuItem(icon: Icons.contact_mail, title: 'Contact us'),
    MenuItem(icon: Icons.history, title: 'History'),
    MenuItem(icon: Icons.palette, title: 'Theme'),
    MenuItem(icon: Icons.share, title: 'Share'),
    MenuItem(icon: Icons.star_rate, title: 'Rate'),
    MenuItem(icon: Icons.logout, title: 'Logout'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Elango'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            // Close the menu
          },
        ),
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
    return ListTile(
      leading: Icon(menuItem.icon, color: Colors.grey),
      title: Text(menuItem.title),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
      tileColor: Colors.white,
      onTap: () {
        // Handle menu item tap
      },
    );
  }
}