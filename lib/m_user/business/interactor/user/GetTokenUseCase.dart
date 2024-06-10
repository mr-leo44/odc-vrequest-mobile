


import '../../service/userLocalService.dart';

class GetTokenUseCase{
  UserLocalService local;


  GetTokenUseCase(this.local);

  Future<String> run(S) async{
    var res = await local.getToken();
    return res;
  }


}