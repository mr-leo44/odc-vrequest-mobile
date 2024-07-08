
import '../../service/userNetworkService.dart';

class SoumettreManagerUseCase{
  UserNetworkService network;


  SoumettreManagerUseCase(this.network);

  Future<bool> run(String name, int id) async{
    var res = await network.soumettreManager(name,id);
    return res;
  }


}