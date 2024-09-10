import 'dart:convert';
//import 'dart:js_interop';

import 'package:odc_mobile_project/m_demande/business/model/Demande.dart';
import 'package:odc_mobile_project/m_demande/business/model/DemandeRequest.dart';
import 'package:odc_mobile_project/m_demande/business/model/Personn.dart';
import 'package:odc_mobile_project/m_demande/business/model/Site.dart';
import 'package:odc_mobile_project/m_demande/business/service/DemandeNetworkService.dart';

import 'package:http/http.dart' as http;
import 'package:odc_mobile_project/m_user/business/model/User.dart';

class DemandeNetworkServiceimpl implements DemandeNetworkService {
  String baseURL;

  DemandeNetworkServiceimpl(this.baseURL);

  @override
  Future<String?> annulerDemande(int id, String token) async {
    final client = http.Client();
    final url = Uri.parse("$baseURL/api/cancelDemande");
    final formData = {"id": id};
    print("formData creer demande $formData");

    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(formData));
    print(json.encode(formData));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    client.close();
  }

  @override
  Future<bool?> creerDemande(DemandeRequest data, String token) async {
    final client = http.Client();
    final url = Uri.parse("$baseURL/api/demandes");

    final formData = data.toJson();
    print("formData creer demande $formData");

    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(formData));
    print(json.encode(formData));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    client.close();
  }

  @override
  Future<Demande?> getDemande(int id, String token) async {
    Demande reponseFinal;

    final response = await http.get(Uri.parse("$baseURL/api/demandes/$id"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("Les donnes sont la : ${data}");
      reponseFinal = Demande.fromJson(data);
      return reponseFinal;
    } else {
      print("echec");
      return null;
    }
  }

  @override
  Future<List<Demande>> listDemande(String token) async {
    List<Demande> reponseFinal = [];
    final response = await http.get(Uri.parse("$baseURL/api/demandes"));
    final data = jsonDecode(response.body) as List<dynamic>;
    if (response.statusCode == 200) {
      for (int i = 0; i < data.length; i++) {
        var item = data[i]['demande'];
        reponseFinal.add(Demande.fromJson(item));
      }
    }

    return reponseFinal;
  }

  @override
  Future<List<Site>> listSite(String token) async {
    var reponseFinal = [
      Site.fromJson({
        "id": 1,
        "name": "Palais du peuple",
        "longitude": 50.0,
        "latitude": 60.0,
      }),
      Site.fromJson({
        "id": 2,
        "name": "Victoire",
        "longitude": 15.0,
        "latitude": 25.0,
      }),
      Site.fromJson({
        "id": 3,
        "name": "Aéroport",
        "longitude": 27.0,
        "latitude": 10.0,
      }),
      Site.fromJson({
        "id": 4,
        "name": "Echangeur",
        "longitude": 35.0,
        "latitude": 23.0,
      }),
    ];

    return reponseFinal;
  }

  @override
  Future<Map<String,dynamic>> nombreDemande(int id) async{
    var res = await http.post(Uri.parse("$baseURL/api/user-demande"),
        body: {"id": id.toString()});
    print(res.body);
    var rep = json.decode(res.body)  ;

    return rep;
  }

  @override
  Future<List<Demande>> lastDemande(int id) async{
    List<Demande> demandes = [];
    var res = await http.post(Uri.parse("$baseURL/api/last-demande"),
        body : {"id" : id.toString()});
    List data = json.decode(res.body) as List;
   print("response $data");
    if (res.statusCode == 200) {
      for (int i = 0; i < data.length; i++) {
        var item = data[i];
        demandes.add(Demande.fromJson(item));
      }
    }
    return demandes;

  }

  @override
  Future<List<Demande>> getAllDemande(int id) async{
    List<Demande> reponseFinal = [];
    final response = await http.post(Uri.parse("$baseURL/api/get-all-demande"),
        body: {'id':id.toString()});
    final data = jsonDecode(response.body) as List<dynamic>;

    if (response.statusCode == 200) {
      for (int i = 0; i < data.length; i++) {
        var item = data[i]['demande'];
        reponseFinal.add(Demande.fromJson(item));
      }


    }

    return reponseFinal;
  }

  @override
  Future<List<Demande>> getDemandeTraite(int id) async{
    List<Demande> reponseFinal = [];
    final response = await http.post(Uri.parse("$baseURL/api/get-demande-traite"),
        body: {'id':id.toString()});
    final data = jsonDecode(response.body) as List<dynamic>;

    if (response.statusCode == 200) {
      for (int i = 0; i < data.length; i++) {
        var item = data[i]['demande'];
        reponseFinal.add(Demande.fromJson(item));
      }


    }

    return reponseFinal;
  }

  @override
  Future<List<Personn>> getUserByName(String name) async{
    List<Personn> userList = [];
    var res = await http.post(Uri.parse("$baseURL/api/get-user-by-name"),
        body: {"name": name});
    print("Trouvé : ${res.body}");
    var data = jsonDecode(res.body) as List<dynamic>;
    for (int i = 0; i < data.length; i++) {
      var item = data[i];
      userList.add(Personn.fromJson(item));
    }
    return userList;
  }
}
