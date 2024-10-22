import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'shop_screen.dart';
import 'bag_screen.dart';
import 'favorite_screen.dart';
import 'profile/profile_screen.dart';


class Navbar extends StatefulWidget {
  final int userId; // Thêm tham số userId

  Navbar({required this.userId}); // Thay đổi hàm khởi tạo để yêu cầu userId

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int navBarIndex = 0;
  bool isDarkMode = false; // Trạng thái dark mode ban đầu

  void _onItemTapped(int index) {
    setState(() {
      navBarIndex = index;
    });
  }

  void _toggleDarkMode(bool value) {
    setState(() {
      isDarkMode = value; // Cập nhật trạng thái dark mode
    });
  }


  List<Widget> get _screens => [
    HomeScreen(),
    ShopScreen(),
    BagScreen(),
    FavoriteScreen(),
    ProfileScreen(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[navBarIndex], // Hiển thị màn hình dựa trên navBarIndex
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: navBarIndex,
        backgroundColor: Color(0xFF44462E),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_sharp),
            label: 'CShop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Bag',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
