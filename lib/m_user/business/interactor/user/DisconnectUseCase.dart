


import '../../service/userLocalService.dart';

class DisconnectUseCase{
  UserLocalService local;


  DisconnectUseCase(this.local);

  Future<dynamic> run() async{
    var res = await local.disconnect();
    return res;
  }


}