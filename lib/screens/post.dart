import 'dart:io';

import 'package:cms_customer/screens/post_details.dart';
import 'package:flutter/material.dart';

import '../location.dart';

class PostRequestScreen extends StatefulWidget {
  final Map<String, dynamic> category;

  const PostRequestScreen({Key? key, required this.category}) : super(key: key);

  @override
  _PostRequestScreenState createState() => _PostRequestScreenState();
}

class _PostRequestScreenState extends State<PostRequestScreen> {
  String? _selectedPostType = 'Public';
  String? _selectedSubCategory;
  Engineer? _selectedEngineer;

  final List<String> _postTypes = ['Public', 'Private'];
  final List<String> _subCategories = ['Sub Category 1', 'Sub Category 2', 'Sub Category 3']; // Update with your subcategories
  final List<Engineer> _engineers = [
    Engineer(name: 'Engineer 1', rating: 4, minimumCharge: 150.00),
    Engineer(name: 'Engineer 2', rating: 5, minimumCharge: 200.00),
    Engineer(name: 'Engineer 3', rating: 3, minimumCharge: 100.00),
  ];

  String? _details;
  List<String>? _imagePaths = [];

  void _navigateToAddDetails({String? details, List<String>? images}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PostDetails(
        details: details,
        images: images,
      )),
    );

    if (result != null) {
      setState(() {
        _details = result['details'];
        _imagePaths = List<String>.from(result['images']);
      });
    }
  }

  void _editDetails() {
    _navigateToAddDetails(details: _details, images: _imagePaths);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Request'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Category',style: Theme.of(context).textTheme.bodyMedium),
            SizedBox(height: 8),
            Row(
              children: [
                CategoryTile(icon: widget.category['icon'], title: widget.category['label']),
              ],
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              value: _selectedSubCategory,
              items: _subCategories.map((String subCategory) {
                return DropdownMenuItem<String>(
                  value: subCategory,
                  child: Text(subCategory,style: Theme.of(context).textTheme.bodyMedium,),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedSubCategory = newValue;
                });
              },
              hint: Text('Select Sub Category',style: Theme.of(context).textTheme.bodyMedium),
              isExpanded: true,
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              value: _selectedPostType,
              items: _postTypes.map((String postType) {
                return DropdownMenuItem<String>(
                  value: postType,
                  child: Text(postType,style: Theme.of(context).textTheme.bodyMedium,),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedPostType = newValue;
                });
              },
              hint: Text('Select Post Type',style: Theme.of(context).textTheme.bodyMedium),
              isExpanded: true,
            ),
            SizedBox(height: 16),
            if (_selectedPostType == 'Private')
              DropdownButton<Engineer>(
                value: _selectedEngineer,
                items: _engineers.map((Engineer engineer) {
                  return DropdownMenuItem<Engineer>(
                    value: engineer,
                    child: EngineerDropdownItem(engineer: engineer),
                  );
                }).toList(),
                onChanged: (Engineer? newValue) {
                  setState(() {
                    _selectedEngineer = newValue;
                  });
                },
                hint: Text('Select Engineer',style: Theme.of(context).textTheme.bodyMedium),
                isExpanded: true,
              ),
            SizedBox(height: 16),
            if (_details == null && _imagePaths!.isEmpty)
              AddItemButton(
                icon: Icons.details,
                title: 'Add details',
                onTap: _navigateToAddDetails,
              )
            else
              Column(
                children: [
                  if (_details != null)
                    Column(
                      children: [
                        Row(
                          children: [
                            Text('Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            Spacer(),
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: _editDetails,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                             width: double.infinity,
                              margin: EdgeInsets.only(top: 8),
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(_details!)
                          ),
                        ),
                      ],
                    ),
                  if (_imagePaths != null && _imagePaths!.isNotEmpty)
                    Wrap(
                      children: _imagePaths!.map((imagePath) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                          child: Stack(
                            children: [
                              Image.file(
                                File(imagePath),
                                height: 100,
                              ),
                              // Positioned(
                              //   right: 0,
                              //   child: IconButton(
                              //     icon: Icon(Icons.edit, color: Colors.blue),
                              //     onPressed: _editDetails,
                              //   ),
                              // ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                ],
              ),
            AddLocationButton(icon: Icons.location_on, title: 'Add Location'),
            Spacer(),
            Center(
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: MaterialButton(
                  color: Color(0xFF22538D),
                  onPressed: () {
                    // Handle post request
                  },
                  child: Text('Confirm Post', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final IconData icon;
  final String title;

  CategoryTile({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Icon(icon, color: Colors.blue),
            SizedBox(width: 8),
            Text(title, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
class AddLocationButton extends StatelessWidget {
  final IconData icon;
  final String title;



  AddLocationButton({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Handle location selection
      },
      child: InkWell(
        onTap: () {
          // Handle location selection
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MapScreen(),
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.only(top: 8),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.blue),
              SizedBox(width: 16),
              Text(title, style:Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
class AddItemButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;


  AddItemButton({required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue),
            SizedBox(width: 16),
            Text(title, style:Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
class Engineer {
  final String name;
  final int rating;
  final double minimumCharge;

  Engineer({required this.name, required this.rating, required this.minimumCharge});
}

class EngineerDropdownItem extends StatelessWidget {
  final Engineer engineer;

  EngineerDropdownItem({required this.engineer});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // CircleAvatar(
        //   backgroundImage: AssetImage(engineer.name),
        //   radius: 20,
        // ),
        //Spacer(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                engineer.name,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < engineer.rating ? Icons.star : Icons.star_border,
                    color: Colors.yellow[700],
                    size: 15,
                  );
                }),
              ),
            ],
          ),
        ),
        Spacer(),
        Text(
          '\₹${engineer.minimumCharge.toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}