import 'package:cms_customer/screens/post.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController userId = TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController mobile = TextEditingController();
 // final TextEditingController _searchController = TextEditingController();


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
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
        title: Text('Profile', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView (
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage('assets/profilepic.jpg'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8.0),
                child: TextField(
                  controller: userId,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.perm_identity),
                    hintText: 'User ID',
                    border: OutlineInputBorder(),
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(
                    //     8.0,
                    //   ),
                    //   borderSide: BorderSide.none,
                    // ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8.0),
                child: TextField(
                  controller: firstName,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.person_outline_outlined),
                    hintText: 'First Name',
                    border: OutlineInputBorder(),
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(
                    //     8.0,
                    //   ),
                    //   borderSide: BorderSide.none,
                    // ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: TextField(
                  controller: lastName,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.person_outline_outlined),
                    hintText: 'Last Name',
                    border: OutlineInputBorder(),
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(
                    //     8.0,
                    //   ),
                    //   borderSide: BorderSide.none,
                    // ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8.0),
                child: TextField(
                  controller: mobile,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.phone_android),
                    hintText: 'Mobile',
                    border: OutlineInputBorder(),
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(
                    //     8.0,
                    //   ),
                    //   borderSide: BorderSide.none,
                    // ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8.0),
                child: TextField(
                  controller: address,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.person_outline_outlined),
                    hintText: 'Address',
                    border: OutlineInputBorder(),
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(
                    //     8.0,
                    //   ),
                    //   borderSide: BorderSide.none,
                    // ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: MaterialButton(
                    color: Color(0xFF22538D),
                    onPressed: () {

                    },
                    child: Text('Save Changes', style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class OrderStatusBadge extends StatelessWidget {
  final String status;

  OrderStatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(status, style: TextStyle(color: Colors.white)),
    );
  }
}
