// home_screen_body.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:cms_customer/screens/categories.dart';
import 'package:cms_customer/screens/history.dart';
import 'package:cms_customer/screens/menu.dart';
import 'package:cms_customer/screens/mypost.dart';
import 'package:cms_customer/screens/notification.dart';
import 'package:cms_customer/screens/post.dart';
import 'package:cms_customer/screens/profile.dart';

import '../bloc/home_screen/home_screen_bloc.dart';
import '../bloc/home_screen/home_screen_event.dart';
import '../bloc/home_screen/home_screen_state.dart';
import '../repository/register_repo.dart';

class HomeScreen extends StatelessWidget {
  final String welcomeMessage;

  HomeScreen({required this.welcomeMessage});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeScreenBloc()..add(LoadTokenEvent()),
      child: HomeScreenBody(welcomeMessage: welcomeMessage),
    );
  }
}

class HomeScreenBody extends StatefulWidget {
  final String welcomeMessage;

  HomeScreenBody({required this.welcomeMessage});

  @override
  _HomeScreenBodyState createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  final ImagePicker _picker = ImagePicker();
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
  late Future<Map<String, dynamic>> _userData;
  @override
  void initState() {
    super.initState();
    _userData = RegisterRepo.fetchUserData();
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
        _filteredCategories = List.from(
            _categories.where((category) => category['label'] == 'More'));
      }
    });
  }

  void _showImageViewer(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: PhotoView(
          imageProvider: AssetImage(imagePath),
          backgroundDecoration: BoxDecoration(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, state) {
        if (state is TokenLoaded) {
          return FutureBuilder<Map<String, dynamic>>(
            future: _userData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final user = snapshot.data!['user'];
                  return Scaffold(
                    appBar: AppBar(
                      title: Text('CMS'),
                      actions: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: IconButton(
                                icon: Icon(Icons.notifications_active_outlined,
                                    color: Colors.black, size: 25),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>
                                        NotificationPage()),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: IconButton(
                                  icon: Icon(Icons.person_outline_outlined,
                                      color: Colors.black, size: 25),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Profile()),
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
                                        _showImageViewer(
                                            context, 'assets/profilepic.jpg');
                                      },
                                      child: Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                              8),
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/profilepic.jpg'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Text(user['first_name'] + ' ' + user['last_name'], style: Theme
                                            .of(context)
                                            .textTheme
                                            .bodyLarge),
                                        Text('Customer', style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xFFF117D1C))),
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
                                  return buildCategoryItem(
                                      context, category['icon'],
                                      category['label']);
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0),
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
                    bottomNavigationBar: CurvedNavigationBar(
                      index: 0,
                      items: <Widget>[
                        Icon(Icons.home, size: 30,
                            color: _selectedIndex == 0 ? Colors.white : Colors
                                .black),
                        Icon(Icons.my_library_books, size: 30,
                            color: _selectedIndex == 1 ? Colors.white : Colors
                                .black),
                        Icon(Icons.add_circle, size: 30,
                            color: _selectedIndex == 2 ? Colors.white : Colors
                                .black),
                        Icon(Icons.history, size: 30,
                            color: _selectedIndex == 3 ? Colors.white : Colors
                                .black),
                        Icon(Icons.more_horiz_outlined, size: 30,
                            color: _selectedIndex == 4 ? Colors.white : Colors
                                .black),
                      ],
                      color: Colors.white,
                      buttonBackgroundColor: Color(0xFF22538D),
                      backgroundColor: Colors.white,
                      animationCurve: Curves.fastEaseInToSlowEaseOut,
                      animationDuration: Duration(milliseconds: 500),
                      onTap: _onItemTapped,
                    ),
                  );
                }
                else {
                  return Center(child: Text('No user data available'));
                }
              } );
        }

        else if (state is TokenLoadFailure) {
          return Scaffold(
            body: Center(child: Text('Failed to load token')),
          );
        }
        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
