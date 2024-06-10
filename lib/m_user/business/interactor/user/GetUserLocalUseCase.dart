


import '../../model/User.dart';
import '../../service/userLocalService.dart';

class GetUserLocalUseCase{
  UserLocalService local;


  GetUserLocalUseCase(this.local);

  Future<User?> run() async{
    var res = await local.getUser();
    return res;
  }


}