class SizeModel {
  final int sizeID;
  final String sizeName;

  SizeModel({
    required this.sizeID,
    required this.sizeName,
  });

  factory SizeModel.fromJson(Map<String, dynamic> json) {
    return SizeModel(
      sizeID: json['SizeID'],
      sizeName: json['SizeName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'SizeID': sizeID,
      'SizeName': sizeName,
    };
  }
}
