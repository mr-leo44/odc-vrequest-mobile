
import 'package:odc_mobile_project/m_user/business/model/User.dart';
import 'package:sembast/sembast.dart';

import '../../business/service/userLocalService.dart';

class UserLocalServiceImpl implements UserLocalService {
  Database db;
  String userKey = 'UserKey';
  String tokenKey = 'TOKENKey';
  var stockage = StoreRef.main();
  UserLocalServiceImpl(this.db);

  @override
  Future<String> getToken() async{
    var data =await stockage.record(tokenKey).get(db) as String?;
    print("data token: $data");
    return Future.value(data);
  }

  @override
  Future<bool> saveToken(String data) async {
    await stockage.record(tokenKey).put(db,data);
    return true;
  }

  @override
  Future<bool> disconnect() async {
    await stockage.record(userKey).delete(db);
    await stockage.record(tokenKey).delete(db);
    return true;
  }

  @override
  Future<User?> getUser() async {
    var data =await stockage.record(userKey).get(db) as Map?;
    print("data local uer $data");
    return Future.value(User.fromJson(data?? {"id": 0}));
  }

  @override
  Future<bool> saveUser(User data) async {
    print("User ${data.toJson()}");
    await stockage.record(userKey).put(db,data.toJson());

    return true;
  }
}

void main() {}
