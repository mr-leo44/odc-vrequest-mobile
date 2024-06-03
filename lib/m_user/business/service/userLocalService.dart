

import '../model/AuthenticateResponse.dart';

abstract class UserLocalService{
  Future<bool> saveToken(String data);
  Future<String> getToken();
  Future<bool> saveUser(AuthenticateResponse data);
  Future<AuthenticateResponse> getUser();
}