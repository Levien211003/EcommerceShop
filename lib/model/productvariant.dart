class ProductVariant {
  final int sizeId;
  final int colorId;
  final int stock;
  final String sizeName;
  final String colorName;

  ProductVariant({
    required this.sizeId,
    required this.colorId,
    required this.stock,
    required this.sizeName,
    required this.colorName,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) {
    return ProductVariant(
      sizeId: json['sizeId'] ?? 0, // Gán giá trị mặc định nếu null
      colorId: json['colorId'] ?? 0, // Gán giá trị mặc định nếu null
      stock: json['stock'] ?? 0, // Gán giá trị mặc định nếu null
      sizeName: json['sizeName'] ?? 'Không xác định', // Gán giá trị mặc định nếu null
      colorName: json['colorName'] ?? 'Không xác định', // Gán giá trị mặc định nếu null
    );
  }
}
