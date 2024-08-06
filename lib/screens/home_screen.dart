import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cms_customer/screens/post.dart';
import 'package:cms_customer/screens/profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:image_picker/image_picker.dart';

import '../repository/login_repo.dart';
import 'categories.dart';
import 'history.dart';
import 'menu.dart';
import 'mypost.dart';
import 'notification.dart';

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
    return WillPopScope(
      onWillPop: () async {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.warning,
          title: 'Exit',
          desc: 'Do you want to Exit?',
          width: 400,
          btnOk: ElevatedButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
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
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
            ),
            child: const Text(
              'No',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ).show();
        return false;
      },
      child: Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
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
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

class HomeScreenBody extends StatefulWidget {
  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  final ImagePicker _picker = ImagePicker();

  String imagePath = 'assets/profilepic.jpg';

  void _showImageViewer(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: PhotoView(
                imageProvider: AssetImage(imagePath),
                backgroundDecoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
            ),
            // Positioned(
            //   top: 10,
            //   right: 10,
            //   child: Row(
            //     children: [
            //       IconButton(
            //         icon: Icon(Icons.edit),
            //         color: Colors.white,
            //         onPressed: () async {
            //           final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
            //           if (pickedFile != null) {
            //             // Replace this with your state management logic
            //             // For example, if you're using a state management solution, update the state accordingly
            //             Navigator.of(context).pop();
            //             _showImageViewer(context, pickedFile.path);
            //           }
            //         },
            //       ),
            //       IconButton(
            //         icon: Icon(Icons.delete),
            //         color: Colors.white,
            //         onPressed: () {
            //           // Replace this with your state management logic
            //           // For example, if you're using a state management solution, update the state accordingly
            //           Navigator.of(context).pop();
            //         },
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget buildCategoryItem(BuildContext context, IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          if (label == 'More') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Categories(),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostRequestScreen(
                  category: {'icon': icon, 'label': label},
                ),
              ),
            );
          }
        },
        child: Card(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30, color: Colors.blue),
              SizedBox(height: 10),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  late List<Map<String, dynamic>> _filteredCategories;
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, dynamic>> _categories = [
    {'icon': Icons.cleaning_services_outlined, 'label': 'Cleaning'},
    {'icon': Icons.build_circle_outlined, 'label': 'Repairing'},
    {'icon': Icons.electrical_services_outlined, 'label': 'Electrician'},
    {'icon': Icons.chair_outlined, 'label': 'Carpenter'},
    {'icon': Icons.filter_tilt_shift_outlined, 'label': 'Fitting'},
    {'icon': Icons.emoji_transportation_outlined, 'label': 'Transport'},
    {'icon': Icons.add_home_work_outlined, 'label': 'Construction'},
    {'icon': Icons.engineering_outlined, 'label': 'Mechanic'},
    {'icon': Icons.more_vert_outlined, 'label': 'More'},

  ];

  @override
  void initState() {
    super.initState();
    _loadToken();
    _filteredCategories = List.from(_categories);
    _searchController.addListener(_filterCategories);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterCategories);
    _searchController.dispose();
    super.dispose();
  }
  void _filterCategories() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredCategories = _categories
          .where((category) =>
          category['label'].toString().toLowerCase().contains(query))
          .toList();
      // Ensure "More" category is included if no matching categories are found
      if (_filteredCategories.isEmpty) {
        _filteredCategories = List.from(_categories.where((category) => category['label'] == 'More'));
      }
    });
  }
  String _token = 'No token found';
  Future<void> _loadToken() async {
    final token = await LoginRepo.getToken();
    setState(() {
      _token = token ?? 'No token found';
    });
    print('Stored Token: $_token'); // Print the token
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(

    //  backgroundColor: Color(0xFFFF3F5FD),
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'CMS',
              style: TextStyle(
                color: Color(0xFFF117D1C),
                // color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
       // backgroundColor: Color(0xFFFFD188),
        elevation: 0,
        toolbarHeight: 80.0, // Increase the height of the AppBar
        actions: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: Icon(Icons.notifications_active_outlined, color: Colors.black),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NotificationPage()),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: Icon(Icons.person_outline_outlined, color: Colors.black),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Profile()),
                      );
                    },
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
                //height: screenHeight * 0.10,
                color: Color(0xFFFFD188),
                padding: EdgeInsets.only(
                  top: screenHeight * 0.02,
                  left: 20,
                  right: 10,
                  bottom: screenHeight * 0.05,
                ),
                child: SizedBox(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _showImageViewer(context, 'assets/profilepic.jpg');
                        },
                        child: Container(
                          width: 60, // Adjust the width as needed
                          height: 60, // Adjust the height as needed
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8), // Adjust the corner radius if needed, or set it to 0 for sharp edges
                            image: DecorationImage(
                              image: AssetImage('assets/profilepic.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Elango Saravanan',style: Theme.of(context).textTheme.bodyLarge,),
                          Text('Customer', style: TextStyle(fontSize: 16, color: Color(0xFFF117D1C),)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.10),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  children: _filteredCategories.map((category) {
                    return buildCategoryItem(context,category['icon'], category['label']);
                  }).toList(),
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
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search for services',
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
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
}
