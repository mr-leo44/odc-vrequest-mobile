import '../../model/User.dart';
import '../../service/userNetworkService.dart';

class GetUserNetworkUseCase{
  UserNetworkService network;


  GetUserNetworkUseCase(this.network);

  Future<User?> run() async{
    var res = await network.getUser();
    return res;
  }


}