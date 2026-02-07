
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:evently/Core/Cloudinary/cloudinary_constants.dart';
import 'package:evently/Core/Firebase/firebase_manager.dart';
import 'package:evently/Core/Shared%20Prefrences/shared_pref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract class ProfileRemoteDs{
  Future<String> uploadUserImage(File imageFile);
  Future<void> updateUserImage(String imageUrl);
  Future<void> logout();
}
@Injectable(as: ProfileRemoteDs)
class ProfileRemoteDsImp implements ProfileRemoteDs{
  late Dio dio;
  ProfileRemoteDsImp() {
  dio = Dio(
    BaseOptions(
      baseUrl: CloudConstants.cloudinaryUploadBaseUrl,
    ),
  );
}
  @override
  Future<String> uploadUserImage(File imageFile) async {
    try{
      FormData imageData = FormData.fromMap(
        {
          "file" : await MultipartFile.fromFile(imageFile.path) ,
          "upload_preset" : CloudConstants.presetName
        }
      );
      final response=await dio.post("/image/upload",data: imageData);
      return response.data['secure_url'];
    }on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<void> updateUserImage( String imageUrl) async {
    try{
      String? userId =PreferencesHelper.getActiveUser();
      await FirebaseManager
          .usersCollection()
          .doc(userId)
          .update({
        "imageUrl": imageUrl,
      });
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      await  PreferencesHelper.clearUser();

    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Logout failed');
    }
  }

}