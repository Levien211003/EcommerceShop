import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Details',
          style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
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
        child: ListView(
          children: [
            // Order header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order №1947034',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text('05-12-2019', style: TextStyle(color: Colors.grey)),
              ],
            ),
            SizedBox(height: 8),
            Text('Tracking number: IW3475453455', style: TextStyle(color: Colors.grey)),
            Text('Delivered', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),

            // Item list
            Text(
              '3 items',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            _buildOrderItem('Pullover', 'Mango', 'Gray', 'L', '51\$', 'assets/item1.png'),
            _buildOrderItem('Pullover', 'Mango', 'Gray', 'L', '51\$', 'assets/item2.png'),
            _buildOrderItem('Pullover', 'Mango', 'Gray', 'L', '51\$', 'assets/item3.png'),
            SizedBox(height: 16),

            // Order information
            Text(
              'Order information',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            _buildOrderInfoRow('Shipping Address', '3 Newbridge Court, Chino Hills, CA 91709, United States'),
            _buildOrderInfoRow('Payment method', '**** **** **** 3947', icon: Icons.credit_card),
            _buildOrderInfoRow('Delivery method', 'FedEx, 3 days, 15\$'),
            _buildOrderInfoRow('Discount', '10%, Personal promo code'),
            _buildOrderInfoRow('Total Amount', '133\$'),
            SizedBox(height: 16),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  child: Text('Reorder'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text('Leave feedback'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItem(String title, String brand, String color, String size, String price, String imagePath) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(imagePath, width: 50, height: 50, fit: BoxFit.cover),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                Text(brand, style: TextStyle(color: Colors.grey)),
                Text('Color: $color  Size: $size', style: TextStyle(color: Colors.grey)),
                Text('Units: 1', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Text(price, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildOrderInfoRow(String title, String info, {IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          if (icon != null)
            Icon(icon, color: Colors.red, size: 20),
          if (icon != null)
            SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Text(info, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
