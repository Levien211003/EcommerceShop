 import 'package:flutter/material.dart';
import 'package:ecommerce_api/model/product.dart';
import 'package:intl/intl.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String selectedSize = 'Size';
  String selectedColor = 'Color';

  String formatPrice(double price) {
    return price.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(?<=\d)(?=(\d{3})+(?!\d))'), (Match m) => '.');
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body:  Container(
      color: Colors.white.withOpacity(0.5), // Nền trắng với độ trong suốt 50%
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: screenHeight * 0.5,
              width: double.infinity,
              color: Colors.white,
              child: Center(
                child: Image.asset(
                  'assets/products/${widget.product.imageUrl}',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.image, size: screenHeight * 0.5),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildDropdown(
                        'Size',
                        <String>['Size', 'S', 'M', 'L', 'XL'],
                        selectedSize,
                        (String? newValue) {
                          setState(() {
                            selectedSize = newValue!;
                          });
                        },
                      ),
                      SizedBox(width: 16),
                      _buildDropdown(
                        'Color',
                        <String>['Color', 'Black', 'Red', 'Blue'],
                        selectedColor,
                        (String? newValue) {
                          setState(() {
                            selectedColor = newValue!;
                          });
                        },
                      ),
                      Spacer(),
                     Container(
  decoration: BoxDecoration(
    color: Colors.white,
    shape: BoxShape.circle,
    border: Border.all(color: Colors.transparent, width: 2),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2), // Màu và độ trong suốt của bóng
        spreadRadius: 2, // Độ rộng của bóng
        blurRadius: 6, // Độ mờ của bóng
        offset: Offset(0, 3), // Độ dịch chuyển của bóng
      ),
    ],
  ),
  child: IconButton(
    icon: Icon(Icons.favorite_border),
    onPressed: () {},
  ),
),

                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product.brand,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                          ),
                          Text(
                            widget.product.name,
                            style: TextStyle(color: Colors.grey, fontSize: 11),
                          ),
                        ],
                      ),
                      Text(
                        '${formatPrice(widget.product.salePrice ?? widget.product.price)} VND',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  _buildStarRating(4.5), // Hiển thị đánh giá sao
                  SizedBox(height: 16),
                  Text(
                    widget.product.description,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 46),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: Text(
                      'ADD TO CART',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Divider(height: 32),
                  ListTile(
                    title: Text('Shipping info'),
                    trailing: Icon(Icons.arrow_forward_ios),
                   onTap: () {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Thông Tin Vận Chuyển"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DataTable(
              columns: [
                DataColumn(label: Text('DVVC')),
                DataColumn(label: Text('Giá')),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('GHTK')),
                  DataCell(Text('30.000 VND')),
                ]),
                DataRow(cells: [
                  DataCell(Text('GHN')),
                  DataCell(Text('25.000 VND')),
                ]),
                DataRow(cells: [
                  DataCell(Text('HT')),
                  DataCell(Text('50.000 VND')),
                ]),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Đóng hộp thoại
            },
            child: Text("Đóng"),
          ),
        ],
      );
    },
  );
},

                  ),
                  ListTile(
                    title: Text('Support'),
                    trailing: Icon(Icons.arrow_forward_ios),
                 onTap: () {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Size Phù Hợp"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DataTable(
              columns: [
                DataColumn(label: Text('Size')),
                DataColumn(label: Text('Cân Nặng')),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('XS')),
                  DataCell(Text('<45kg')),
                ]),
                DataRow(cells: [
                  DataCell(Text('S')),
                  DataCell(Text('45-50kg')),
                ]),
                DataRow(cells: [
                  DataCell(Text('M')),
                  DataCell(Text('50-55kg')),
                ]),
                DataRow(cells: [
                  DataCell(Text('L')),
                  DataCell(Text('55-65kg')),
                ]),
                 DataRow(cells: [
                  DataCell(Text('XL')),
                  DataCell(Text('65-75kg')),
                ]),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Đóng hộp thoại
            },
            child: Text("Đóng"),
          ),
        ],
      );
    },
  );
},

                  ),
                  Divider(height: 32),
                  Text(
                    'You can also like this',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildRecommendedItem('Evening Dress', '15', '12', '20%'),
                        _buildRecommendedItem('T-Shirt Sailing', '10', '10', 'NEW'),
                        _buildRecommendedItem('T-Shirt', '10', '10', 'NEW'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),);
  }

  // Widget để xây dựng dropdown
 Widget _buildDropdown(String label, List<String> items, String selectedValue, ValueChanged<String?> onChanged) {
  return Container(
    height: 40,
    width: 138,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: selectedValue == label ? Colors.orange : Colors.grey, width: 1),
      borderRadius: BorderRadius.circular(8),
    ),
    child: DropdownButton<String>(
      value: selectedValue,
      isExpanded: true, // Giúp text và dropdown icon căn giữa
      alignment: Alignment.center, // Đảm bảo text căn giữa
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Center(child: Text(value)), // Đặt text vào giữa
        );
      }).toList(),
      onChanged: onChanged,
      underline: SizedBox(),
    ),
  );
}


  // Widget để hiển thị đánh giá sao
  Widget _buildStarRating(double rating) {
    List<Widget> stars = [];
    int fullStars = rating.floor();
    bool halfStar = rating - fullStars >= 0.5;

    for (int i = 0; i < 5; i++) {
      if (i < fullStars) {
        stars.add(Icon(Icons.star, color: Colors.yellow));
      } else if (i == fullStars && halfStar) {
        stars.add(Icon(Icons.star_half, color: Colors.yellow));
      } else {
        stars.add(Icon(Icons.star_border, color: Colors.grey));
      }
    }

    return Row(
      children: stars,
    );
  }

  Widget _buildRecommendedItem(String name, String oldPrice, String newPrice, String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: 120,
                height: 150,
                color: Colors.grey[300],
                child: Center(child: Text(name, textAlign: TextAlign.center)),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  color: Colors.red,
                  child: Text(
                    label,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Text(
                '\$$oldPrice',
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey,
                ),
              ),
              SizedBox(width: 4),
              Text(
                '\$$newPrice',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
