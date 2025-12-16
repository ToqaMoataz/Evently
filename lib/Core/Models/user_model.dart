class UserModel {
  String id;
  final String name;
  final String email;
  final String phone;
  final String location;
  final String imageUrl;

  UserModel({
    this.id = "",
    required this.name,
    required this.email,
    required this.phone,
    this.location = "Your Location",
    this.imageUrl = "",
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "phone": phone,
      "location": location,
      "imageUrl": imageUrl,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      phone: json["phone"] ?? "",
      location: json["location"] ?? "Your Location",
      imageUrl: json["imageUrl"] ?? "",
    );
  }
}
