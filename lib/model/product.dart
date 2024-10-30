class Product {
  int? productID; // Nullable
  String name;
  String description;
  double price;
  double? salePrice; // Nullable vì có thể không phải tất cả sản phẩm đều có giảm giá
  int? stock; // Nullable
  int? idCategory; // Nullable

  String imageUrl;
  DateTime createdAt;
  DateTime updatedAt;
  String gender;   
  String subCategory;   
  String brand;
  double? discountPercentage; // Tỷ lệ giảm giá (nullable)

  Product({
    required this.productID,
    required this.name,
    required this.description,
    required this.price,
    required this.salePrice, // Có thể null nếu không có giảm giá
    required this.idCategory,
    required this.stock,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.gender,
    required this.subCategory,
    required this.brand,
    this.discountPercentage, // Có thể null nếu không có giảm giá
  });

  // Tính salePrice nếu có discountPercentage
  void calculateSalePrice() {
    if (discountPercentage != null && discountPercentage! > 0) {
      salePrice = price * (1 - discountPercentage! / 100);
    } else {
      salePrice = price; // Nếu không có giảm giá, giữ nguyên giá gốc
    }
  }

  // Chuyển từ JSON sang đối tượng Product
  factory Product.fromJson(Map<String, dynamic> json) {
    var product = Product(
      productID: json['productID'] as int?,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      salePrice: null, // Ban đầu chưa tính salePrice
      idCategory: json['idcategory'] as int?,
      stock: json['stock'] != null ? (json['stock'] as int) : null,
      imageUrl: json['imageUrl'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      gender: json['gender'] as String,
      subCategory: json['subCategory'] as String,
      brand: json['brand'] as String,
      discountPercentage: json['discountPercentage'] != null
          ? (json['discountPercentage'] as num).toDouble()
          : null, // Kiểm tra null và chuyển sang double
    );

    // Tính salePrice nếu có discountPercentage
    product.calculateSalePrice();
    
    return product;
  }

  // Chuyển từ đối tượng Product sang JSON
  Map<String, dynamic> toJson() {
    return {
      'productID': productID,
      'name': name,
      'description': description,
      'price': price,
      'salePrice': salePrice, // Bao gồm salePrice
      'idcategory': idCategory,
      'stock': stock,
      'imageUrl': imageUrl,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'gender': gender,
      'subCategory': subCategory,
      'brand': brand,
      'discountPercentage': discountPercentage,
    };
  }
}
