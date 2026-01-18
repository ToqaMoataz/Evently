import 'dart:io';


import '../Repository/local_repo.dart';
import '../Repository/remote_repo.dart';

class UploadUserImageUC {
  final ProfileRemoteRepo remoteRepo;
  final ProfileLocalRepo localRepo;

  UploadUserImageUC(this.remoteRepo,this.localRepo);

  Future<void> call() async {
    try {
      File? imageFile=await localRepo.pickUserImage();
      if(imageFile==null) return;
      String url= await remoteRepo.uploadUserImage(imageFile);
      await remoteRepo.updateUserImage(url);
    } catch (e) {
      rethrow;
    }
  }
}
