import 'package:flutter/material.dart';

class ShopScreen extends StatefulWidget {
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  int selectedTab = 0; // Chỉ số của tab hiện tại (0: Women, 1: Men, 2: Unisex)
  List<String> categories = [
    'Áo thun',
    'Áo sơ mi & Áo kiểu',
    'Áo khoác',
    'Đồ len',
    'Blazers',
    'Quần dài',
    'Quần short',
    'Đầm váy'
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height; // Lấy chiều cao màn hình
    double itemHeight = screenHeight / 8; // Chiều cao mỗi item = 1/8 chiều cao màn hình

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4,
        shadowColor: Colors.grey.withOpacity(0.2),
        leading: SizedBox.shrink(),
        title: Text(
          'Categories',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {
              // Xử lý sự kiện tìm kiếm
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Thanh tab dùng chung cho cả hai slide
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildCategoryTab('Women', 0),
                buildCategoryTab('Men', 1),
                buildCategoryTab('Unisex', 2),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical, // Đặt hướng cuộn là dọc
              children: [
                // Slide 1: Banner và Danh mục chính
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    // Banner Sale
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'SUMMER SALES',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                'Up to 50% off',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    // Danh sách các danh mục (New, Clothes, Shoes, Accessories)
                    buildCategoryItem('New', 'assets/Female/Female1.png', itemHeight),
                    buildCategoryItem('Clothes', 'assets/Female/Female2.png', itemHeight),
                    buildCategoryItem('Shoes', 'assets/Female/Female3.png', itemHeight),
                    buildCategoryItem('Accessories', 'assets/Female/Female4.png', itemHeight),
                  ],
                ),

                // Slide 2: Nút View All Items và danh sách các item phụ
                SingleChildScrollView(
                  child: Container(
                    color: Color(0xFFF9F9F9), // Màu nền cho slide 2
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20), // Khoảng cách từ trên xuống
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Text(
                                'VIEW ALL ITEMS',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'Choose Category',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        // List category chi tiết
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                              child: Column(
                                children: [
                                  Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 16.0),
                                        child: Text(
                                          categories[index],
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.grey.withOpacity(0.4),
                                    thickness: 0.4,
                                    height: 0,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget cho tab category (Women, Men, Kids)
  Widget buildCategoryTab(String label, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = index;
        });
      },
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: selectedTab == index ? Colors.red : Colors.black,
              fontWeight: selectedTab == index ? FontWeight.bold : FontWeight.normal,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 8),
          if (selectedTab == index)
            Container(
              height: 2,
              width: 30,
              color: Colors.red,
            ),
        ],
      ),
    );
  }

  // Widget cho danh mục sản phẩm
  Widget buildCategoryItem(String title, String imagePath, double itemHeight) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        height: itemHeight, // Chiều cao item = 1/8 chiều cao màn hình
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Text bên trái
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              width: itemHeight / 0.55, 
              height: itemHeight, // Chiều cao hình ảnh bằng với item
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
