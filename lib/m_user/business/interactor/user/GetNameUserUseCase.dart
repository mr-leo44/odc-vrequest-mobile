
import '../../service/userNetworkService.dart';

class GetNameUserUseCase{
  UserNetworkService network;


  GetNameUserUseCase(this.network);

  Future<List<String>> run(String name) async{
    var res = await network.getNameUser(name);
    return res;
  }


}