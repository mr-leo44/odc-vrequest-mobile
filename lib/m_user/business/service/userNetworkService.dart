

import 'package:odc_mobile_project/m_user/business/model/Authenticate.dart';

import '../model/AuthenticateResponse.dart';

abstract class UserNetworkService{
  Future<AuthenticateResponse?> authenticate(AuthenticateRequestBody data);
}