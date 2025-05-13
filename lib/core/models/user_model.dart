class UserModel {
  final String id;
  final String phone;
  final String password;
  final String role;

  UserModel({
    required this.id,
    required this.phone,
    required this.password,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']??'',
      phone: json['phone'] ?? '',
      password: json['password'] ?? '',
      role: json['role'] ?? 'user', // default to user
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'password': password,
      'role': role,
    };
  }

  UserModel copyWith({
    String? phone,
    String? password,
    String? role,
  }) {
    return UserModel(
      id: id,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      role: role ?? this.role,
    );
  }
}
