class ColorModel {
  final int colorID;
  final String colorName;

  ColorModel({
    required this.colorID,
    required this.colorName,
  });

  factory ColorModel.fromJson(Map<String, dynamic> json) {
    return ColorModel(
      colorID: json['ColorID'],
      colorName: json['ColorName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ColorID': colorID,
      'ColorName': colorName,
    };
  }
}
