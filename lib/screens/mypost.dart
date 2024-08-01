import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xFFFF3F5FD),
        appBar: AppBar(
          backgroundColor: Color(0xFF22538D),
          title: Text('Orders',style: TextStyle(color: Colors.white) ,),
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'Post',),
              Tab(text: 'Requests'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PostTab(),
            RequestsTab(),
          ],
        ),
      ),
    );
  }
}

class PostTab extends StatefulWidget {
  @override
  _PostTabState createState() => _PostTabState();
}

class _PostTabState extends State<PostTab> {
  Future<void> _refresh() async {
    // Perform your data fetching or refreshing logic here.
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView(
        padding: EdgeInsets.all(16),
        children: [
          OrderTile(),
        ],
      ),
    );
  }
}

class RequestsTab extends StatefulWidget {
  @override
  _RequestsTabState createState() => _RequestsTabState();
}

class _RequestsTabState extends State<RequestsTab> {
  Future<void> _refresh() async {
    // Perform your data fetching or refreshing logic here.
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('assets/profile.jpg'),
                      ),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('S.Elango\n Cleaner', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      Spacer(),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              // Add your cancel button logic here
                            },
                            icon: Icon(Icons.cancel_outlined, color: Colors.red),
                          ),
                          IconButton(
                            onPressed: () {
                              // Add your accept button logic here
                            },
                            icon: Icon(Icons.check_circle_outline, color: Colors.green),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class OrderTile extends StatelessWidget {
  Future<void> _refresh() async {
    // Perform your data fetching or refreshing logic here.
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Card(
        // padding: EdgeInsets.all(16),
        // decoration: BoxDecoration(
        //   color: Colors.white,
        //   borderRadius: BorderRadius.circular(8),
        // ),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.cleaning_services, color: Colors.blue),
                  SizedBox(width: 8),
                  Text('Cleaning', style: TextStyle(fontSize: 16)),
                  Spacer(),
                  Column(
                    children: [
                      OrderStatusBadge(status: 'Pending'),
                      SizedBox(height: 4),
                      Text('2 hrs ago', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
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
        color: Colors.orange,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(status, style: TextStyle(color: Colors.white)),
    );
  }
}
