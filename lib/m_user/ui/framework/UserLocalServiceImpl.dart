import 'package:get_storage/get_storage.dart';
import 'package:odc_mobile_project/m_user/business/model/AuthenticateResponse.dart';
import 'package:odc_mobile_project/m_user/business/model/User.dart';

import '../../business/service/userLocalService.dart';

class UserLocalServiceImpl implements UserLocalService{
  GetStorage stockage;

  UserLocalServiceImpl(this.stockage);

  @override
  Future<String> getToken() {
   var data= stockage.read("TOKEN")??"1|KE0ezAjUzFrRbvBVHvIl9VSshhiHPVtqqJKwHQhO738b167d";
   print("data token: $data");
   return Future.value(data);
  }



  @override
  Future<bool> saveToken(String data) async {
    await  stockage.write("TOKEN", data);
    return true;
  }

 

  @override
  Future disconnect() {
    // TODO: implement disconnect
    throw UnimplementedError();
  }

  @override
  Future<User?> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<bool> saveUser(User data) {
    // TODO: implement saveUser
    throw UnimplementedError();
  }

}