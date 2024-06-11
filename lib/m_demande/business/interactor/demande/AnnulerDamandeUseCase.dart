import 'package:odc_mobile_project/m_demande/business/service/DemandeNetworkService.dart';
import 'package:odc_mobile_project/m_user/business/service/userLocalService.dart';

class AnnulerDemandeUseCase {
  DemandeNetworkService network;
 UserLocalService userLocal;

  AnnulerDemandeUseCase(this.network, this.userLocal);

  Future<String?> run(int id) async {
    String token = await userLocal.getToken();
    var res = await network.annulerDemande(id, token);
    return res;
  }
}
