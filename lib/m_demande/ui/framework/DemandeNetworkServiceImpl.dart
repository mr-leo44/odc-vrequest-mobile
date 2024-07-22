import 'dart:convert';
//import 'dart:js_interop';

import 'package:odc_mobile_project/m_demande/business/model/Demande.dart';
import 'package:odc_mobile_project/m_demande/business/model/DemandeRequest.dart';
import 'package:odc_mobile_project/m_demande/business/model/Site.dart';
import 'package:odc_mobile_project/m_demande/business/service/DemandeNetworkService.dart';

import 'package:http/http.dart' as http;
import 'package:odc_mobile_project/m_user/business/model/User.dart';

class DemandeNetworkServiceimpl implements DemandeNetworkService {
  String baseURL;

  DemandeNetworkServiceimpl(this.baseURL);

  @override
  Future<String?> annulerDemande(int id, String token) async {
    // TODO: implement getDemande
    throw UnimplementedError();
  }

  @override
  Future<String?> creerDemande(DemandeRequest data, String token) async {
    // TODO: implement getDemande
    throw UnimplementedError();
  }

  @override
  Future<Demande> getDemande(int id, String token) {
    // TODO: implement getDemande
    throw UnimplementedError();
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
}
