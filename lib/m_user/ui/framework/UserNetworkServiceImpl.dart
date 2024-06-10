
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:odc_mobile_project/m_user/business/model/Authenticate.dart';
import 'package:odc_mobile_project/m_user/business/model/User.dart';
import 'dart:convert';

import '../../business/model/AuthenticateResponse.dart';
import '../../business/service/userNetworkService.dart';

class UserNetworkServiceImpl implements UserNetworkService{
  // var baseURL=dotenv.env['BASE_URL'];
  String baseURL;

  UserNetworkServiceImpl(this.baseURL);


  @override
  Future<AuthenticateResponse> authenticate(AuthenticateRequestBody data) async{
    var res= await http.post(Uri.parse("$baseURL/api/login"),
    body: data.toJson());
    var reponseMap=json.decode(res.body) as Map;
    print("responseMap $reponseMap");
    var reponseFinal=AuthenticateResponse.fromJson(reponseMap);
    return reponseFinal;
  }

  @override
  Future<User> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }
}

void main(){
  var baseUrlTest="http://";
  var impl=UserNetworkServiceImpl(baseUrlTest);
  var data=AuthenticateRequestBody(email: "email", password: "password");
  impl.authenticate(data);
}