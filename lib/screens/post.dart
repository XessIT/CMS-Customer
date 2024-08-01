import 'package:flutter/material.dart';


class PostRequestScreen extends StatelessWidget {
  final Map<String, dynamic> category;

  const PostRequestScreen({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFF3F5FD),
      appBar: AppBar(
        backgroundColor: Color(0xFF22538D),
        title: Text('Post Request',style: TextStyle(color: Colors.white) ,),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ) ,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Category', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Row(
              children: [
                CategoryTile(icon: category['icon'], title: category['label']),
                //AddCategoryButton(),
              ],
            ),
            SizedBox(height: 16),
            AddItemButton(icon: Icons.category_outlined, title: 'Select Sub Category'),
            AddItemButton(icon: Icons.details, title: 'Add details'),
            AddItemButton(icon: Icons.location_on, title: 'Add Location'),

            Spacer(),
            Center(
              child: SizedBox(
                width: double.infinity,
                height: 40,
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
            Text(title, style: TextStyle(fontSize: 16)),
           // SizedBox(width: 8),
           // Icon(Icons.close, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

/*
class AddCategoryButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.only(left: 16),
      // padding: EdgeInsets.all(8),
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(8),
      // ),
      child: IconButton(icon: Icon(Icons.add), onPressed: () {
        Navigator.pop(context);
      }), // Icon(Icons.add, color: Colors.grey),
    );
  }
}
*/

class AddItemButton extends StatelessWidget {
  final IconData icon;
  final String title;

  AddItemButton({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Text(title, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
