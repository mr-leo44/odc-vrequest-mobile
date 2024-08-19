import 'package:odc_mobile_project/m_demande/business/model/Demande.dart';
import 'package:odc_mobile_project/m_demande/business/model/DemandeRequest.dart';
import '../model/Site.dart';

abstract class DemandeNetworkService {
  Future<bool?> creerDemande(DemandeRequest data, String token);

  Future<String?> annulerDemande(int id, String token);

  Future<List<Demande>> listDemande(String token);

  Future<Demande?> getDemande(int id, String token);

  Future<List<Site>> listSite(String token);
  Future<Map<String,dynamic>> nombreDemande(int id);
  Future<List> lastDemande(int id);
  Future<List<Demande>> getAllDemande(int id);
  Future<List<Demande>> getDemandeTraite(int id);
}
