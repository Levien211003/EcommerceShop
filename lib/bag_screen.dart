import 'package:flutter/material.dart';

class MyBagScreen extends StatefulWidget {
  @override
  _MyBagScreenState createState() => _MyBagScreenState();
}

class _MyBagScreenState extends State<MyBagScreen> {
  int itemCount1 = 1;
  int itemCount2 = 1;
  int itemCount3 = 1;

  void _showPromoCodeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Your Promo Codes'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                _buildPromoCard("10% off", "Personal offer", "mypromocode2020", "6 days remaining"),
                _buildPromoCard("15% off", "Summer Sale", "summer2020", "23 days remaining"),
                _buildPromoCard("22% off", "Personal offer", "mypromocode2020", "6 days remaining"),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPromoCard(String discount, String title, String code, String remaining) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                color: Colors.red,
                child: Text(
                  discount,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(code, style: TextStyle(color: Colors.grey)),
                  Text(remaining, style: TextStyle(color: Colors.grey)),
                ],
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              // Code for applying the promo code
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text("Apply"),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(String imagePath, String title, String color, String size, int price, int itemCount, Function onDecrease, Function onIncrease) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width * 340 / 375,
      height: MediaQuery.of(context).size.height * 105 / 700,
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
          Container(
            width: 105,
            height: 105,
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
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
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove_circle_outline),
                            onPressed: onDecrease as void Function()?,
                          ),
                          Text('$itemCount'),
                          IconButton(
                            icon: Icon(Icons.add_circle_outline),
                            onPressed: onIncrease as void Function()?,
                          ),
                        ],
                      ),
                      Text('\$$price', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int totalAmount = (51 * itemCount1) + (30 * itemCount2) + (43 * itemCount3);

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
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("My Bag", style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
                 
                ],
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildProductCard(
                      'assets/products/aothun.png',
                      'Pullover',
                      'Black',
                      'L',
                      51,
                      itemCount1,
                      () => setState(() => itemCount1 = itemCount1 > 1 ? itemCount1 - 1 : 1),
                      () => setState(() => itemCount1++),
                    ),
                    _buildProductCard(
                      'assets/products/AdidasTShirt.png',
                      'T-Shirt',
                      'Gray',
                      'L',
                      30,
                      itemCount2,
                      () => setState(() => itemCount2 = itemCount2 > 1 ? itemCount2 - 1 : 1),
                      () => setState(() => itemCount2++),
                    ),
                    _buildProductCard(
                      'assets/products/AdidasHoodie.png',
                      'Sport Dress',
                      'Black',
                      'M',
                      43,
                      itemCount3,
                      () => setState(() => itemCount3 = itemCount3 > 1 ? itemCount3 - 1 : 1),
                      () => setState(() => itemCount3++),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            // Container for Promotion and Total Amount
            Container(
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: _showPromoCodeDialog,
                    child: TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        hintText: 'Enter your promo code',
                        suffixIcon: Icon(Icons.arrow_forward),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total amount:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('\$$totalAmount', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text('CHECK OUT', style: TextStyle(color: Colors.white,fontSize: 18)),
            ),
                        SizedBox(height: 16),

          ],
        ),
      ),
    );
  }
}
