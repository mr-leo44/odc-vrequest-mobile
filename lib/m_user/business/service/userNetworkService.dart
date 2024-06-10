

import 'package:odc_mobile_project/m_user/business/model/Authenticate.dart';

import '../model/AuthenticateResponse.dart';
import '../model/User.dart';

abstract class UserNetworkService{
  Future<User?> getUser();
  Future<AuthenticateResponse?> authenticate(AuthenticateRequestBody data);
}