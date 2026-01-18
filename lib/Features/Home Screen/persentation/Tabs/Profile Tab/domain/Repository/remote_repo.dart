import 'dart:io';

abstract class ProfileRemoteRepo{
  Future<String> uploadUserImage(File imageFile);
  Future<void> updateUserImage(String imageUrl);
  Future<void> logout();
}