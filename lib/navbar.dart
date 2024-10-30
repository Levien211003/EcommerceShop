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
  int navBarIndex = 0; // Chỉ số của navBar hiện tại

  void _onItemTapped(int index) {
    setState(() {
      navBarIndex = index; // Cập nhật chỉ số navBar
    });
  }

  List<Widget> get _screens => [
    HomeScreen(),
    ShopScreen(),
    MyBagScreen(),
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
        backgroundColor: Colors.white, // Đặt màu nền trong suốt
        selectedItemColor: Colors.redAccent, // Màu khi chọn
        unselectedItemColor: Colors.black, // Màu chữ khi không chọn
        onTap: _onItemTapped,
        items: List.generate(5, (index) {
          IconData icon;
          String label;

          switch (index) {
            case 0:
              icon = Icons.home;
              label = 'Home';
              break;
            case 1:
              icon = Icons.shopping_cart_sharp;
              label = 'Shop';
              break;
            case 2:
              icon = Icons.shopping_bag;
              label = 'Bag';
              break;
            case 3:
              icon = Icons.favorite;
              label = 'Favorite';
              break;
            case 4:
              icon = Icons.person;
              label = 'Profile';
              break;
            default:
              icon = Icons.home;
              label = 'Home';
          }

          return BottomNavigationBarItem(
            icon: Icon(
              icon,
              color: navBarIndex == index ? Colors.redAccent : Colors.black, // Màu icon theo trạng thái
            ),
            label: label,
            // Màu chữ
            backgroundColor: Colors.transparent, // Màu nền item trong suốt
          );
        }),
      ),
    );
  }
}
