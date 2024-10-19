class Users {
  int userId;
  String username;
  String email;
  String passwordHash;
  String role;
  String fullName;
  String phoneNumber;
  String? profileImage; // Cho phép NULL
  DateTime createdAt;
  bool isDeleted;

  Users({
    required this.userId,
    required this.username,
    required this.email,
    required this.passwordHash,
    required this.role,
    required this.fullName,
    required this.phoneNumber,
    this.profileImage,
    required this.createdAt,
    required this.isDeleted,
  });

  // Chuyển từ JSON sang đối tượng Users
  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      userId: json['UserID'],
      username: json['Username'],
      email: json['Email'],
      passwordHash: json['PasswordHash'],
      role: json['Role'],
      fullName: json['FullName'],
      phoneNumber: json['PhoneNumber'],
      profileImage: json['ProfileImage'] != null ? json['ProfileImage'] : '',
      createdAt: DateTime.parse(json['CreatedAt']),
      isDeleted: json['IsDeleted'] == 1 || json['IsDeleted'] == true, // Xử lý kiểu bool cho isDeleted
    );
  }

  // Chuyển từ đối tượng Users sang JSON
  Map<String, dynamic> toJson() {
    return {
      'UserID': userId,
      'Username': username,
      'Email': email,
      'PasswordHash': passwordHash,
      'Role': role,
      'FullName': fullName,
      'PhoneNumber': phoneNumber,
      'ProfileImage': profileImage,
      'CreatedAt': createdAt.toIso8601String(),
      'IsDeleted': isDeleted,
    };
  }
}
