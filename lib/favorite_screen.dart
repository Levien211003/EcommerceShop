import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Map<String, dynamic>> favorites = [
    {
      'imagePath': 'assets/products/aothun.png',
      'brand': 'LIME',
      'name': 'Shirt',
      'color': 'Blue',
      'size': 'L',
      'price': 32,
      'rating': 4.5,
      'ratingCount': 10,
      'isSoldOut': false,
      'discount': null,
    },
    {
      'imagePath': 'assets/products/AdidasTShirt.png',
      'brand': 'Mango',
      'name': 'LevisOveralls',
      'color': 'Orange',
      'size': 'S',
      'price': 46,
      'rating': 0.0,
      'ratingCount': 0,
      'isSoldOut': false,
      'discount': 'NEW',
    },
    {
      'imagePath': 'assets/products/AdidasHoodie.png',
      'brand': 'Olivier',
      'name': 'LacosteHoodie',
      'color': 'Gray',
      'size': 'L',
      'price': 52,
      'rating': 4.0,
      'ratingCount': 3,
      'isSoldOut': true,
      'discount': null,
    },
  ];

  List<String> categories = ['Shirts', 'Jeans', 'Polos', 'T-Shirts', 'Hoodies'];
  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   appBar: AppBar(
        backgroundColor: Colors.transparent,
        
        elevation: 0,
        toolbarHeight: 0, centerTitle: true,
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.search, color: Colors.black),
        //     onPressed: () {
        //       // Xử lý sự kiện tìm kiếm
        //     },
        //   ),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Favorite title
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                "Favorite",
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 16),

            // Category row
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(categories.length, (index) {
                  bool isSelected = selectedCategoryIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategoryIndex = index;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.black : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: 16),

            // Filter and sort row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: () {
                    // Add filter functionality
                  },
                ),
                Text("Price: lowest to highest"),
                IconButton(
                  icon: Icon(Icons.view_module),
                  onPressed: () {
                    // Toggle between grid and list view
                  },
                ),
              ],
            ),
            SizedBox(height: 16),

            // Product List
            Expanded(
              child: ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final item = favorites[index];
                  return _buildProductCard(
                    item['imagePath'],
                    '${item['brand']} ${item['name']}',
                    item['color'],
                    item['size'],
                    item['price'],
                    item['rating'],
                    item['ratingCount'],
                    item['isSoldOut'],
                    item['discount'],
                    () {
                      setState(() {
                        favorites.removeAt(index);
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(
    String imagePath,
    String title,
    String color,
    String size,
    int price,
    double rating,
    int ratingCount,
    bool isSoldOut,
    String? discount,
    VoidCallback onDelete,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 105,
                height: 105,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
              if (discount != null)
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    color: Colors.red,
                    child: Text(
                      discount,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text('Color: $color   Size: $size', style: TextStyle(color: Colors.grey)),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow, size: 16),
                      Text('$rating ($ratingCount)', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  if (isSoldOut)
                    Text(
                      'Sorry, this item is currently sold out',
                      style: TextStyle(color: Colors.red),
                    ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('\$$price', style: TextStyle(fontWeight: FontWeight.bold)),
              IconButton(
                icon: Icon(Icons.favorite, color: Colors.red),
                onPressed: onDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
