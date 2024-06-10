


import '../../service/userLocalService.dart';

class SaveTokenUseCase{
  UserLocalService local;


  SaveTokenUseCase(this.local);

  Future<bool> run(String data) async{
    var res = await local.saveToken(data);
    return res;
  }


}