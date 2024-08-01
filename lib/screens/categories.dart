import 'package:cms_customer/screens/post.dart';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
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
    {'icon': Icons.format_paint_outlined, 'label': 'Painting'},
  ];

  late List<Map<String, dynamic>> _filteredCategories;

  @override
  void initState() {
    super.initState();
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
    });
  }

  Widget buildCategoryItem(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostRequestScreen(
                category: {'icon': icon, 'label': label},
              ),
            ),
          );        },
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
      ),
    );
  }
  Future<void> _refresh() async {
    // Perform your data fetching or refreshing logic here.
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFF3F5FD),
      appBar: AppBar(
        backgroundColor: Color(0xFF22538D),
        title: Text('Post Request',style: TextStyle(color: Colors.white) ,),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Column(
          children: [
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _searchController,
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
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                children: _filteredCategories.map((category) {
                  return buildCategoryItem(category['icon'], category['label']);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
