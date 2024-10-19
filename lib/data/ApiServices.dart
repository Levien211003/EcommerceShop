import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ecommerce_api/model/product.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.1.10:7163/api';

  // Lấy sản phẩm theo danh mục
  Future<List<Product>> getProductsByCategory(String categoryName) async {
    final url = Uri.parse('$baseUrl/Products/category/$categoryName');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Chuyển đổi JSON thành danh sách sản phẩm
        List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData.map((product) => Product.fromJson(product)).toList();
      } else if (response.statusCode == 404) {
        // Không tìm thấy sản phẩm
        return [];
      } else {
        throw Exception('Lỗi khi lấy sản phẩm: ${response.body}');
      }
    } catch (e) {
      throw Exception('Lỗi kết nối đến server: $e');
    }
  }

  // Lấy tất cả tên danh mục sản phẩm
  Future<List<String>> getAllCategoryNames() async {
    final url = Uri.parse('$baseUrl/Products/categorynames');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Chuyển đổi JSON thành danh sách tên danh mục
        List<dynamic> jsonData = jsonDecode(response.body);
        return List<String>.from(jsonData);
      } else if (response.statusCode == 404) {
        // Không tìm thấy danh mục nào
        return [];
      } else {
        throw Exception('Lỗi khi lấy tên danh mục: ${response.body}');
      }
    } catch (e) {
      throw Exception('Lỗi kết nối đến server: $e');
    }
  }

  // Lấy sản phẩm theo đánh giá
  Future<List<Product>> getProductsByRating(int rating) async {
    final url = Uri.parse('$baseUrl/Products/rating/$rating');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Chuyển đổi JSON thành danh sách sản phẩm
        List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData.map((product) => Product.fromJson(product)).toList();
      } else if (response.statusCode == 404) {
        // Không tìm thấy sản phẩm
        return [];
      } else {
        throw Exception('Lỗi khi lấy sản phẩm: ${response.body}');
      }
    } catch (e) {
      throw Exception('Lỗi kết nối đến server: $e');
    }
  }


  // Lấy sản phẩm trong vòng 7 ngày gần đây
  // Thay đổi phương thức getRecentProducts
Future<List<Product>> getRecentProducts() async {
  final url = Uri.parse('$baseUrl/products/recent');
  try {
    final response = await http.get(url);
    print('Response status: ${response.statusCode}'); // In trạng thái phản hồi
    print('Response body: ${response.body}'); // In thân phản hồi

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((product) => Product.fromJson(product)).toList();
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw Exception('Lỗi khi lấy sản phẩm gần đây: ${response.body}');
    }
  } catch (e) {
    print('Caught error: $e'); // Thêm dòng này để in lỗi ra console
    throw Exception('Lỗi kết nối đến server: $e');
  }
}
  // Lấy sản phẩm đang giảm giá
  Future<List<Product>> getSaleProducts() async {
  final url = Uri.parse('$baseUrl/products/sale');
  try {
    final response = await http.get(url);
    print('Response status: ${response.statusCode}'); // In trạng thái phản hồi
    print('Response body: ${response.body}'); // In thân phản hồi

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((product) {
        // Chuyển đổi từ JSON thành Product, bạn có thể điều chỉnh theo model của bạn
        return Product(
          productID: product['productID'],
          name: product['name'],
          description: product['description'],
          price: product['price'], // Giá gốc
          salePrice: product['salePrice'], // Giá sau khi giảm (salePrice)
          category: product['category'],
          stock: product['stock'],
          imageUrl: product['imageUrl'],
          createdAt: DateTime.parse(product['createdAt']),
          updatedAt: DateTime.parse(product['updatedAt']),
          gender: product['gender'],
          subCategory: product['subCategory'],
          brand: product['brand'],
        );
      }).toList();
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw Exception('Lỗi khi lấy sản phẩm đang giảm giá: ${response.body}');
    }
  } catch (e) {
    print('Caught error: $e'); // Thêm dòng này để in lỗi ra console
    throw Exception('Lỗi kết nối đến server: $e');
  }
}

  }