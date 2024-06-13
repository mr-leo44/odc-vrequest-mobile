

import '../model/AuthenticateResponse.dart';
import '../model/User.dart';

abstract class UserLocalService{
  Future<bool> saveToken(String data);
  Future<String> getToken();

  Future<bool> saveUser(User data);

  Future<User?> getUser();
  Future<bool> disconnect();
}