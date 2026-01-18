import 'dart:io';

import 'package:evently/Features/Home%20Screen/persentation/Tabs/Profile%20Tab/data/Data%20source/local_ds.dart';
import 'package:evently/Features/Home%20Screen/persentation/Tabs/Profile%20Tab/domain/Repository/local_repo.dart';

class ProfileLocalRepoImp extends ProfileLocalRepo{
  ProfileLocalRepoImp(this.ds);
  ProfileLocalDs ds;

  @override
  Future<File?> pickUserImage() async {
    try{
      File? imageFile=await ds.pickUserImage();
      return imageFile;
    }catch(e){rethrow;}
  }

}