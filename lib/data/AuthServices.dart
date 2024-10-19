import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl = 'http://192.168.1.10:7163/api';

  // Đăng ký người dùng
  Future<String> register({
    required String username,
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
  }) async {
    final url = Uri.parse('$baseUrl/User/register');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'Username': username,
          'Email': email,
          'Password': password,
          'FullName': fullName,
          'PhoneNumber': phoneNumber,
        }),
      );

      if (response.statusCode == 200) {
        return 'Đăng ký thành công';
      } else {
        return 'Đăng ký thất bại: ${response.body}';
      }
    } catch (e) {
      return 'Lỗi khi kết nối đến server: $e';
    }
  }

  // Đăng nhập
  Future<String> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/User/login');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'Email': email,
          'Password': password,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // Kiểm tra xem phản hồi có phải là JSON không
        if (response.body.startsWith('{') && response.body.endsWith('}')) {
          try {
            final data = jsonDecode(response.body);

            if (data.containsKey('userId')) {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setInt('userId', data['userId']);
              await prefs.setString('user', jsonEncode(data));

              // Ghi log ra console để kiểm tra userId
              print('User ID: ${data['userId']}'); // Thêm dòng này để log userId

              return 'Đăng nhập thành công';
            } else {
              return 'Không tìm thấy thông tin người dùng (userId).';
            }
          } catch (e) {
            print('Error during JSON decoding: $e');
            return 'Đăng nhập thất bại: Dữ liệu trả về không hợp lệ.';
          }
        } else {
          // Xử lý trường hợp phản hồi là một chuỗi thông báo đơn giản
          return response.body;
        }
      } else {
        return 'Đăng nhập thất bại với mã lỗi: ${response.statusCode}, chi tiết: ${response.body}';
      }
    } catch (e) {
      return 'Lỗi khi kết nối đến server: $e';
    }
  }

  // Đăng xuất người dùng
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user') != null;
  }
}
