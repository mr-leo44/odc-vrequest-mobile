import '../../model/User.dart';
import '../../service/userLocalService.dart';
import '../../service/userNetworkService.dart';

class GetUserNetworkUseCase{
  UserNetworkService network;
  UserLocalService local;


  GetUserNetworkUseCase(this.network,this.local);

  Future<User?> run() async{
    var token =await  local.getToken();
    var res = await network.getUser(token);
    if(res!=null){

      var user=User.fromJson(res.toJson());
      local.saveUser(user);
    }
    return res;
  }


}