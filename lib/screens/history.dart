import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, String>> _historyItems = [
    {'category': 'Cleaning', 'status': 'Completed'},
    {'category': 'Repairing', 'status': 'Pending'},
    {'category': 'Electrician', 'status': 'In Progress'},
    // Add more items as needed
  ];

  @override
  void initState() {
    super.initState();
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
    // Implement your filtering logic here
  }

  Future<void> _refresh() async {
    // Perform your data fetching or refreshing logic here.
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
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
                  hintText: 'Find your history',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _historyItems.length,
                itemBuilder: (context, index) {
                  final item = _historyItems[index];
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
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
                                Text(item['category']!, style: TextStyle(fontSize: 16)),
                                Spacer(),
                                OrderStatusBadge(status: item['status']!),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
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
        color: _getStatusColor(status),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(status, style: TextStyle(color: Colors.white)),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return Colors.green;
      case 'Pending':
        return Colors.orange;
      case 'In Progress':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
