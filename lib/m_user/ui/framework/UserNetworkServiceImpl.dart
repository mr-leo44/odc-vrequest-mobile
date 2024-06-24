
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
    print(res.body);
    var reponseMap=json.decode(res.body) as Map;
    print("responseMap $reponseMap");
    var reponseFinal=AuthenticateResponse.fromJson(reponseMap);
    return reponseFinal;
  }

  @override
  Future<User> getUser(String token) async{
    var res= await http.get(Uri.parse("$baseURL/api/user"),
        headers: {"Authorization": "Bearer $token"});
    var reponseMap=json.decode(res.body) as Map;
    print("responseMap $reponseMap");
    var responseFinal= User.fromJson(reponseMap);
    return responseFinal;
}
}


void main(){
  var baseUrlTest="http://10.252.252.20:8000";
  var impl=UserNetworkServiceImpl(baseUrlTest);
  var data=AuthenticateRequestBody(email: "salomon@gmail.com", password: "azertyui");
  impl.authenticate(data);
  impl.getUser("24|Lxhf5hFIeirVzrFwfRX9q3fXF7YFLwyBakQDhLTR42677743");
}