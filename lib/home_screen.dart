import 'package:ecommerce_api/data/ApiServices.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_api/model/product.dart';
import 'package:intl/intl.dart'; // Import thư viện
import 'new_page.dart';
import 'sale_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  Future<List<Product>>? futureRecentProducts;
  Future<List<Product>>? futureSaleProducts;

  @override
  void initState() {
    super.initState();
    futureRecentProducts = apiService.getRecentProducts();
    futureSaleProducts = apiService.getSaleProducts();
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Image Section
            Stack(
              children: [
                Image.asset(
                  'assets/banner.png',
                  width: double.infinity,
                  height: 400,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 40,
                  left: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fashion\nSale',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                     ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SalePage()),
    );
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.red,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
  ),
  child: Text(
    'Check',
    style: TextStyle(
      color: Colors.white,
      fontSize: 18,
    ),
  ),
),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Phần sản phẩm đang sale
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sale',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                   GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SalePage()),
            );
          },
          child:
                  Text(
                    'View all',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.orange,
                    ),
                  ),
                   ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Danh sách sản phẩm đang sale",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 20),

            // Hiển thị danh sách sản phẩm sale
            FutureBuilder<List<Product>>(
              future: futureSaleProducts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('Không có sản phẩm đang sale.'));
                }

                List<Product> products = snapshot.data!;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    height: 210,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        Product product = products[index];
                        bool hasDiscount = product.salePrice != null &&
                            product.salePrice! < product.price;

                        return Container(
                          width: 160,
                          margin: EdgeInsets.only(right: 16.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        'assets/products/${product.imageUrl}',
                                        height: 130,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Icon(Icons.image, size: 130),
                                      ),
                                    ),
                                  ),
                                  if (hasDiscount)
                                    Positioned(
                                      top: 10,
                                      left: 10,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.7),
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                  fontSize: 10,
                                ),
                              ),
                              SizedBox(height: 5),
                              if (hasDiscount)
                                Column(
                                  children: [
                                    Text(
                                      formatCurrency(product.price),
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10,
                                        decoration:
                                            TextDecoration.lineThrough,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      formatCurrency(product.salePrice!),
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
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
                        );
                      },
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20),

            // Recent Products Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'New',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                     GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewPage()),
            );
          },
          child:
                  Text(
                    'View all',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.orange,
                    ),
                  ),
                   ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Giá rẻ bất ngờ, tại toàn đồ giả!",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 20),

            // Products Horizontal List
            FutureBuilder<List<Product>>(
              future: futureRecentProducts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No recent products found.'));
                }

                List<Product> products = snapshot.data!;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    height: 260,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        Product product = products[index];

                        return Container(
                          width: 160,
                          margin: EdgeInsets.only(right: 16.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        'assets/products/${product.imageUrl}',
                                        height: 130,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Icon(Icons.image, size: 130),
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
                                  fontSize: 10,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                formatCurrency(product.price),
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
