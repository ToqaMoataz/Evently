import 'package:evently/Core/Cloudinary/cloudinary_constants.dart';
import 'package:hive_flutter/adapters.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel extends HiveObject{
  @HiveField(0)
  String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String phone;
  @HiveField(4)
  final String location;
  @HiveField(5)
  final String imageUrl;

  UserModel({
    this.id = "",
    required this.name,
    required this.email,
    required this.phone,
    this.location = "My Location",
    this.imageUrl = CloudConstants.defaultUserImage,
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
      location: json["location"] ?? "My Location",
      imageUrl:
      json["imageUrl"] ?? CloudConstants.defaultUserImage,
    );
  }
}
