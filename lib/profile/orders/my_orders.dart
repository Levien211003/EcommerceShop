import 'package:flutter/material.dart';
import 'package:ecommerce_api/profile/orders/orders_details.dart';

class MyOrdersScreen extends StatefulWidget {
  @override
  _MyOrdersScreenState createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  String selectedTab = 'Delivered';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tiêu đề My Orders
            Text(
              'My Orders',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 20),

            // Tab bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTabButton('Delivered'),
                _buildTabButton('Processing'),
                _buildTabButton('Cancelled'),
              ],
            ),
            SizedBox(height: 16),

            // Danh sách đơn hàng
            Expanded(
              child: ListView.builder(
                itemCount: 2, // Dùng số lượng đơn hàng thực tế
                itemBuilder: (context, index) {
                  return _buildOrderCard();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget cho Tab button với khung viền đen khi được chọn
  Widget _buildTabButton(String title) {
    bool isSelected = title == selectedTab;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = title;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? Colors.black : Colors.transparent),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  // Widget cho thẻ đơn hàng
  Widget _buildOrderCard() {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order №1947034',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '05-12-2019',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text('Tracking number: IW3475453455', style: TextStyle(color: Colors.grey)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Quantity: 3', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Total Amount: 112\$', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             OutlinedButton(
              onPressed: () {
                // Điều hướng đến OrderDetailsScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderDetailsScreen()),
                );
              },
              child: Text('Details'),
            ),
              Text(
                'Delivered',
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
