import 'package:flutter/material.dart';
import 'package:ecommerce_api/data/ApiServices.dart';
import 'package:ecommerce_api/model/product.dart';
import 'package:intl/intl.dart';

class NewPage extends StatefulWidget {
  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  final ApiService apiService = ApiService();
  Future<List<Product>>? futureRecentProducts;

  @override
  void initState() {
    super.initState();
    futureRecentProducts = apiService.getRecentProducts();
  }

  String formatCurrency(double price) {
    final NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: '₫',
      decimalDigits: 0,
    );
    return currencyFormatter.format(price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sản phẩm mới'),
      ),
      body: FutureBuilder<List<Product>>(
        future: futureRecentProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Không có sản phẩm mới.'));
          }

          List<Product> products = snapshot.data!;

          return GridView.builder(
            padding: const EdgeInsets.all(16.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Số cột trong lưới
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 0.7, // Tỷ lệ chiều rộng và chiều cao của từng sản phẩm
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              Product product = products[index];
              bool hasDiscount = product.salePrice != null && product.salePrice! < product.price;

              return GestureDetector(
                onTap: () {
                  // Xử lý sự kiện khi nhấn vào sản phẩm (nếu cần)
                },
                child: Container(
                  
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 5), // Đổ bóng
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'assets/products/${product.imageUrl}',
                              height: 210,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Icon(Icons.image, size: 150),
                            ),
                          ),
                          if (hasDiscount)
                            Positioned(
                              top: 10,
                              left: 10,
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  '${((1 - (product.salePrice! / product.price)) * 100).toStringAsFixed(0)}% OFF',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        product.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 5),
                      if (hasDiscount)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              formatCurrency(product.price),
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            Text(
                              formatCurrency(product.salePrice!),
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        )
                      else
                        Text(
                          formatCurrency(product.price),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
