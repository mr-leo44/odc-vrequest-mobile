import '../../model/User.dart';
import '../../service/userNetworkService.dart';

class GetUserNetworkUseCase{
  UserNetworkService network;


  GetUserNetworkUseCase(this.network);

  Future<User?> run(String token) async{
    var res = await network.getUser(token);
    return res;
  }


}