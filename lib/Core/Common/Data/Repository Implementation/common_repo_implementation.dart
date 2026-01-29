
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

import '../../Domain/Repository/common_repo.dart';
import '../Data source/common_local_data_source.dart';
@Injectable(as: CommonRepo)
class SharedRepoIMP extends CommonRepo{
  SharedRepoIMP(this.ds);
  CommonLocalDS ds;
  @override
  Future<LatLng?> getCurrentPosition() async {
    try{
      LatLng? position=await ds.getCurrentPosition();
      return position;
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<Placemark?> getUserLocation(LatLng position) async {
    try{
      Placemark? list=await ds.getUserLocation(position);
      return list;
    }catch(e){
      rethrow;
    }
  }
}