

import 'package:odc_mobile_project/m_user/business/model/OnboardingPageModel.dart';

import '../model/AuthenticateResponse.dart';
import '../model/User.dart';

abstract class UserLocalService{
  Future<bool> saveToken(String data);
  Future<String> getToken();

  Future<bool> saveUser(User data);

  Future<User?> getUser();
  Future<bool> disconnect();

  Future<bool?> getStatusOnboard();
  List<OnboardingPageModel> getListOnboard();
  Future terminateOnboard();
}