import 'package:odc_mobile_project/m_demande/business/model/Demande.dart';
import 'package:odc_mobile_project/m_demande/business/model/DemandeRequest.dart';
import '../model/Site.dart';

abstract class DemandeNetworkService {
  Future<String?> creerDemande(DemandeRequest data);

  Future<String?> annulerDemande(int id);

  Future<List<Demande>> listDemande();

  Future<Demande> getDemande(int id);

  Future<List<Site>> listSite();
}
