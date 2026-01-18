import 'dart:io';

import 'package:evently/Features/Home%20Screen/persentation/Tabs/Profile%20Tab/data/Data%20source/local_ds.dart';
import 'package:evently/Features/Home%20Screen/persentation/Tabs/Profile%20Tab/domain/Repository/local_repo.dart';

import '../../domain/Repository/remote_repo.dart';
import '../Data source/remote_ds.dart';

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