

import '../model/Authenticate.dart';
import '../model/AuthenticateResponse.dart';
import '../model/User.dart';
import '../service/userLocalService.dart';
import '../service/userNetworkService.dart';

class Authenticateusecase{
  UserNetworkService network;
  UserLocalService local;

  Authenticateusecase(this.network, this.local);

  Future<AuthenticateResponse?> run(AuthenticateRequestBody data) async{
     var res=await network.authenticate(data);
    if(res!=null){
      local.saveToken(res.token);
      var user=User.fromJson(res.toJson());
      local.saveUser(user);
    }
    return res;
  }


}