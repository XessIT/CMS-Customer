import 'package:cms_customer/screens/post.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'menu.dart';
import 'mypost.dart';

class HomeScreen extends StatefulWidget {
  final String welcomeMessage;
  HomeScreen({required this.welcomeMessage});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final List<Widget> _pages = [
    OrdersScreen(),
    PostRequestScreen(),
    MenuScreen(),
    MenuScreen(),

  ];
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
          //
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
       backgroundColor:Color(0xFFFF3F5FD),

      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('CMS', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
            // Uncomment and adjust if you want to add a subtitle
            // Text('Care my service', style: TextStyle(color: Color(0xFF117D1C), fontSize: 8, fontWeight: FontWeight.bold)),
          ],
        ),
         backgroundColor:Color(0xFF22538D),
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
        ]
      ),
      body:

      Stack(

        children: [
          Column(
            children: [
              Container(
                color: Color(0xFF22538D),
                padding: EdgeInsets.all(8.0),
                child: const Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/profile.jpg'), // Update with the actual image path
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Elango Saravanan', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white)),
                        Text('Customer', style: TextStyle(fontSize: 16, color: Colors.white)),
                      ],
                    ),
                    SizedBox(height: 100),
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
            top: 100, // Adjust this value to position the search bar vertically
            left: 8, // Adjust this value to position the search bar horizontally
            right: 8, // Ensure to give some padding on the right
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
          _pages[_page],
        ],
      ),

      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: _page == 0 ? Colors.white : Colors.black,
          ),
          Icon(
            Icons.my_library_books,
            size: 30,
            color: _page == 1 ? Colors.white : Colors.black,
          ),
          Icon(
            Icons.add_circle,
            size: 30,
            color: _page == 2 ? Colors.white : Colors.black,
          ),
          Icon(
            Icons.history,
            size: 30,
            color: _page == 3 ? Colors.white : Colors.black,
          ),
          Icon(
            Icons.more_horiz_outlined,
            size: 30,
            color: _page == 4 ? Colors.white : Colors.black,
          ),
        ],
        color: Colors.white,
        buttonBackgroundColor: Color(0xFF22538D),
        backgroundColor: Color(0xFF22538D),
        animationCurve: Curves.fastEaseInToSlowEaseOut,
        animationDuration: Duration(milliseconds: 500),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }

  Widget buildCategoryItem(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        // elevation: 5,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(10),
        // ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: Colors.black), // You can customize the icon color here
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
