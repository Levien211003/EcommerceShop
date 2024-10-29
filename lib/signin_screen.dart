import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/AuthServices.dart';
import 'signup_screen.dart';
import 'navbar.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _message = '';
  bool _isLoading = false;

  final AuthService _authService = AuthService();

  Future<void> _handleSignIn() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _message = 'Vui lòng điền đầy đủ thông tin.';
      });
      return;
    }

    setState(() {
      _isLoading = true; // Bắt đầu loading
    });

    // Gọi hàm login từ AuthService
    String result = await _authService.login(email: email, password: password);
    setState(() {
      _isLoading = false; // Kết thúc loading
      _message = result;  // Hiển thị thông báo
    });

    if (result == 'Đăng nhập thành công') {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Giả sử server trả về userId, có thể bạn cần thay đổi theo cách bạn lấy thông tin user
      final String? userJson = prefs.getString('user');
      if (userJson != null) {
        final userData = jsonDecode(userJson);
        int userId = userData['userId'];

        // Điều hướng sang Navbar với tham số userId
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Navbar(userId: userId),
          ),
        );
      } else {
        _showErrorDialog('Không tìm thấy thông tin người dùng.');
      }
    } else {
      _showErrorDialog(result); // Hiển thị thông báo lỗi
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Thông báo'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                SizedBox(height: 16.0),
                Text(
                  'Đăng Nhập',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 32.0),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Mật khẩu',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpScreen()),
                        );
                      },
                     child: Row(
  children: [
    Text(
      "Bạn chưa có tài khoản? Đăng ký",
      style: TextStyle(
        color: Colors.pink,
     
      ),
    ),
    SizedBox(width: 4.0),
    Icon(Icons.arrow_forward, color: Colors.red),
  ],
),

                    ),
                  ],
                ),
                SizedBox(height: 32.0),
                SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleSignIn,
                    child: _isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text('ĐĂNG NHẬP'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32.0),
                Center(
                  child: Column(
                    children: [
                      Text('Hoặc đăng nhập bằng tài khoản xã hội'),
                      SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Xử lý đăng nhập bằng Google
                            },
                            child: Image.asset(
                              'assets/google.png',
                              width: 50,
                              height: 50,
                            ),
                          ),
                          SizedBox(width: 32.0),
                          GestureDetector(
                            onTap: () {
                              // Xử lý đăng nhập bằng Facebook
                            },
                            child: Image.asset(
                              'assets/facebook.png',
                              width: 50,
                              height: 50,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
