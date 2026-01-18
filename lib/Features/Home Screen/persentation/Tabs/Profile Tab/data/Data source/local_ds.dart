import 'dart:io';

import 'package:image_picker/image_picker.dart';

abstract class ProfileLocalDs{
  Future<File?> pickUserImage();
}

class ProfileLocalDsImp implements ProfileLocalDs{
  late ImagePicker _picker;

  ProfileLocalDsImp(){
    _picker=ImagePicker();
  }
  @override
  Future<File?> pickUserImage() async {
    try{
      XFile? imageFile=await _picker.pickImage(source: ImageSource.gallery);
      return (imageFile!=null) ? File(imageFile.path) : null;
    }catch(e){
      rethrow;
    }
  }

}