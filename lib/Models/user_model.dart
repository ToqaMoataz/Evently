class UserModel {
  late String id;
  final String name;
  final String email;
  final String phoneNumber;

  UserModel({
    this.id="",
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  /// Convert Firestore JSON → UserModel
  static UserModel fromJson(Map<String, dynamic> json, {String id = ""}) {
    return UserModel(
      id: id,
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'] as String,
    );
  }

  /// Convert UserModel → Firestore JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }
}
