class Sale {
  int saleID; // Khóa chính
  int productID; // ID của sản phẩm
  double discountPercentage; // Phần trăm giảm giá

  Sale({
    required this.saleID,
    required this.productID,
    required this.discountPercentage,
  });

  factory Sale.fromJson(Map<String, dynamic> json) {
    return Sale(
      saleID: json['saleID'] as int,
      productID: json['productID'] as int,
      discountPercentage: (json['discountPercentage'] as num).toDouble(), // Chuyển đổi từ decimal
    );
  }

  // Chuyển từ đối tượng Sale sang JSON
  Map<String, dynamic> toJson() {
    return {
      'saleID': saleID,
      'productID': productID,
      'discountPercentage': discountPercentage,
    };
  }
}
