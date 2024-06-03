import 'package:get_storage/get_storage.dart';
import 'package:odc_mobile_project/m_user/business/model/AuthenticateResponse.dart';

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
  Future<AuthenticateResponse> getUser() {
    var data= stockage.read("USER")?? {};
    return Future.value(AuthenticateResponse.fromJson(data));
  }

  @override
  Future<bool> saveToken(String data) async {
    await  stockage.write("TOKEN", data);
    return true;
  }

  @override
  Future<bool> saveUser(AuthenticateResponse data) async{
    await stockage.write("USER", data.toJson());
    return true;
  }

}