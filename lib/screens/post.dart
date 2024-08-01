import 'package:flutter/material.dart';


class PostRequestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Request'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
                CategoryTile(icon: Icons.cleaning_services, title: 'Cleaning'),
                AddCategoryButton(),
              ],
            ),
            SizedBox(height: 16),
            AddItemButton(icon: Icons.location_on, title: 'Add Address'),
            AddItemButton(icon: Icons.details, title: 'Add details'),
            AddItemButton(icon: Icons.photo, title: 'Add photos'),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle post request
                },
                child: Text('Confirm Post'),
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
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          SizedBox(width: 8),
          Text(title, style: TextStyle(fontSize: 16)),
          SizedBox(width: 8),
          Icon(Icons.close, color: Colors.grey),
        ],
      ),
    );
  }
}

class AddCategoryButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(Icons.add, color: Colors.grey),
    );
  }
}

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
