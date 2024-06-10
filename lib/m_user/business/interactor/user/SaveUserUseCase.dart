


import '../../model/User.dart';
import '../../service/userLocalService.dart';

class SaveUserUseCase{
  UserLocalService local;


  SaveUserUseCase(this.local);

  Future<bool> run(User data) async{
    var res = await local.saveUser(data);
    return res;
  }


}