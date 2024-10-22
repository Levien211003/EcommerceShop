import 'package:ecommerce_api/profile/orders/my_orders.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 80.0, left: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Profile',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/banner2.png'), 
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Matilda Brown',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text('matildabrown@mail.com', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 32),

            // Profile options with navigation to MyOrdersScreen
            _buildProfileOption(
              'My orders', 
              'Already have 12 orders',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyOrdersScreen()),
                );
              },
            ),
            _buildProfileOption('Shipping addresses', '3 addresses'),
            _buildProfileOption('Payment methods', 'Visa **34'),
            _buildProfileOption('Promocodes', 'You have special promocodes'),
            _buildProfileOption('My reviews', 'Reviews for 4 items'),
            _buildProfileOption('Settings', 'Notifications, password'),
          ],
        ),
      ),
    );
  }

  // Thêm tham số onTap vào _buildProfileOption
  Widget _buildProfileOption(String title, String subtitle, {VoidCallback? onTap}) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(subtitle, style: TextStyle(color: Colors.grey)),
          trailing: Icon(Icons.chevron_right),
          onTap: onTap, // Kích hoạt hàm onTap khi nhấn vào tùy chọn
        ),
      ],
    );
  }
}
