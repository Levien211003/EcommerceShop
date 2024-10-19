import 'package:ecommerce_api/data/ApiServices.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_api/model/product.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  Future<List<Product>>? futureRecentProducts;

  @override
  void initState() {
    super.initState();
    futureRecentProducts = apiService.getRecentProducts(); // Khởi tạo tại đây
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
                        onPressed: () {},
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
                  Text(
                    'View all',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Không có sản phẩm đang sale",
                style: TextStyle(color: Colors.grey),
              ),
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
                  Text(
                    'View all',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "You've never seen it before!",
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

                // Hiển thị danh sách sản phẩm gần đây
                List<Product> products = snapshot.data!;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    height: 220, // Chiều cao của danh sách
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal, // Cuộn ngang
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        Product product = products[index];
                        return Container(
                          width: 160, // Chiều rộng của mỗi sản phẩm
                          margin: EdgeInsets.only(right: 16.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.transparent), // Border màu xám
                            borderRadius: BorderRadius.circular(20), // Bo tròn góc
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                             Stack(
  children: [
    Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.transparent), // Border transparent
        borderRadius: BorderRadius.circular(10), // Bo tròn góc
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10), // Bo tròn cho hình ảnh
        child: Image.asset(
          'assets/products/${product.imageUrl}', // Thay đổi đường dẫn đến asset
          height: 130,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              Icon(Icons.image, size: 200),
        ),
      ),
    ),
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
          'NEW',
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
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                '\VND${product.price.toStringAsFixed(2)}',
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
