import 'dart:io';
import 'package:injectable/injectable.dart';

import '../../domain/Repository/remote_repo.dart';
import '../Data source/remote_ds.dart';
@Injectable(as: ProfileRemoteRepo)
class ProfileRemoteRepoImp extends ProfileRemoteRepo{
  ProfileRemoteRepoImp(this.ds);
  ProfileRemoteDs ds;

  @override
  Future<String> uploadUserImage(File imageFile) async {
    try{
      String? image=await ds.uploadUserImage(imageFile);
      return image;
    }catch(e){rethrow;}
  }

  @override
  Future<void> updateUserImage(String imageUrl) async {
    try{
      await ds.updateUserImage(imageUrl);
    }catch(e){rethrow;}
  }

  @override
  Future<void> logout() async {
    try {
      await ds.logout();
    } catch (e) {
      rethrow;
    }
  }

}