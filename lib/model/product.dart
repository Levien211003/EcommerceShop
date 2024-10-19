class Product {
  int? productID; // Chuyển sang nullable
  String name;
  String description;
  double price;
  String category;
  int? stock; // Chuyển sang nullable
  String imageUrl;
  DateTime createdAt;
  DateTime updatedAt;

  Product({
    required this.productID,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.stock,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
  return Product(
    productID: json['productID'] as int, // Kiểm tra kiểu dữ liệu
    name: json['name'] as String,
    description: json['description'] as String,
    price: (json['price'] as num).toDouble(), // Chuyển đổi từ decimal
    category: json['category'] as String,
    stock: json['stock'] != null ? (json['stock'] as int) : 0, // Kiểm tra null
    imageUrl: json['imageUrl'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
    updatedAt: DateTime.parse(json['updatedAt'] as String),
  );
}


  // Chuyển từ đối tượng Product sang JSON
  Map<String, dynamic> toJson() {
    return {
      'productID': productID,
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'stock': stock,
      'imageUrl': imageUrl,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
