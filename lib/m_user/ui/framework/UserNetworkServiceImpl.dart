
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
    //print(res.body);
    var reponseMap=json.decode(res.body) as Map;
    print("responseMap USER $reponseMap");
    var reponseFinal=AuthenticateResponse.fromJson(reponseMap);
    return reponseFinal;
  }

  @override
  Future<User> getUser(String token) async{
    var res= await http.get(Uri.parse("$baseURL/api/getuser"),
        headers: {"Authorization": "Bearer $token"});
    print("body response getuser: ${res.body}");
    var reponseMap=json.decode(res.body) as Map;
    print("responseMap $reponseMap");
    var responseFinal= User.fromJson(reponseMap);
    return responseFinal;
  }

  @override
  Future<List<String>> getNameUser(String name) async{
    var res = await http.post(Uri.parse("$baseURL/api/getnameuser"),
        body: {"name": name});
    print(res.body);
    List<dynamic> decodedResponse = json.decode(res.body) as List<dynamic>;
    List<String> nameList = decodedResponse.map((item) => item.toString()).toList();
    print("response $nameList");
    return nameList;
  }

  @override
  Future<bool> soumettreManager(String name, int id) async{
    await http.post(Uri.parse("$baseURL/api/savemanager"),
        body: {"id" : id.toString(), "name": name});
    return true;
  }


}


void main(){
  var baseUrlTest="http://10.252.252.52:8000";
  var impl=UserNetworkServiceImpl(baseUrlTest);
  var data=AuthenticateRequestBody(username: "sjayes0", password: "123456");
  var name = 'fra';
  impl.authenticate(data);
  //impl.getUser("187|gWx4d9uY8IgWWPLO6UZ5t7Ay22wAmFktri8ME5XT7d0be974");
  //impl.getNameUser(name);
  //impl.soumettreManager("jayes", 1001);

}