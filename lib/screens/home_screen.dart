import 'package:cms_customer/screens/post.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'categories.dart';
import 'history.dart';
import 'menu.dart';
import 'mypost.dart';

class HomeScreen extends StatefulWidget {
  final String welcomeMessage;

  HomeScreen({required this.welcomeMessage});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showWelcomeDialog();
    });
  }

  void _showWelcomeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Welcome'),
        content: Text(widget.welcomeMessage),
        actions: [
          // You can add actions if needed
        ],
      ),
    );
  }
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static List<Widget> _widgetOptions = <Widget>[
    HomeScreenBody(),
    OrdersScreen(),
    Categories(),
    History(),
    MenuScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:_widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        items: <Widget>[
          Icon(Icons.home, size: 30, color: _selectedIndex == 0 ? Colors.white : Colors.black),
          Icon(Icons.my_library_books, size: 30, color: _selectedIndex == 1 ? Colors.white : Colors.black),
          Icon(Icons.add_circle, size: 30, color: _selectedIndex == 2 ? Colors.white : Colors.black),
          Icon(Icons.history, size: 30, color: _selectedIndex == 3 ? Colors.white : Colors.black),
          Icon(Icons.more_horiz_outlined, size: 30, color: _selectedIndex == 4 ? Colors.white : Colors.black),
        ],
        color: Colors.white,
        buttonBackgroundColor: Color(0xFF22538D),
        backgroundColor: Colors.white,
        animationCurve: Curves.fastEaseInToSlowEaseOut,
        animationDuration: Duration(milliseconds: 500),
        onTap:_onItemTapped,
      ),
    );
  }
}

class HomeScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFFF3F5FD),
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('CMS', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
          ],
        ),
        backgroundColor: Color(0xFF22538D),
        elevation: 0,
        actions: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: Icon(Icons.notifications_active_outlined, color: Colors.black),
                  onPressed: () {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: Icon(Icons.person_outline_outlined, color: Colors.black),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                color: Color(0xFF22538D),
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/profile.jpg'),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Elango Saravanan', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                        Text('Customer', style: TextStyle(fontSize: 16, color: Colors.white)),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.10),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  children: [
                    buildCategoryItem(Icons.cleaning_services_outlined, 'Cleaning'),
                    buildCategoryItem(Icons.build_circle_outlined, 'Repairing'),
                    buildCategoryItem(Icons.electrical_services_outlined, 'Electrician'),
                    buildCategoryItem(Icons.chair_outlined, 'Carpenter'),
                    buildCategoryItem(Icons.filter_tilt_shift_outlined, 'Fitting'),
                    buildCategoryItem(Icons.emoji_transportation_outlined, 'Transport'),
                    buildCategoryItem(Icons.add_home_work_outlined, 'Construction'),
                    buildCategoryItem(Icons.engineering_outlined, 'Mechanic'),
                    buildCategoryItem(Icons.format_paint_outlined, 'Painting'),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 100,
            left: 8,
            right: 8,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Find a service',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategoryItem(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: Colors.blue),
            SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
