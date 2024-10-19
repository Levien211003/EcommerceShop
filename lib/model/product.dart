class Product {
  int productId;
  String name;
  String description;
  double price;
  String category;
  int stock;
  String imageUrl;
  DateTime createdAt;
  DateTime updatedAt;

  Product({
    required this.productId,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.stock,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  // Chuyển từ JSON sang đối tượng Product
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['ProductID'],
      name: json['Name'],
      description: json['Description'],
      price: (json['Price'] as num).toDouble(),
      category: json['Category'],
      stock: json['Stock'],
      imageUrl: json['ImageUrl'],
      createdAt: DateTime.parse(json['CreatedAt']),
      updatedAt: DateTime.parse(json['UpdatedAt']),
    );
  }

  // Chuyển từ đối tượng Product sang JSON
  Map<String, dynamic> toJson() {
    return {
      'ProductID': productId,
      'Name': name,
      'Description': description,
      'Price': price,
      'Category': category,
      'Stock': stock,
      'ImageUrl': imageUrl,
      'CreatedAt': createdAt.toIso8601String(),
      'UpdatedAt': updatedAt.toIso8601String(),
    };
  }
}
