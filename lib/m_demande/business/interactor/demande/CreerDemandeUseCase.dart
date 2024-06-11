import 'package:odc_mobile_project/m_demande/business/model/DemandeRequest.dart';
import 'package:odc_mobile_project/m_demande/business/service/DemandeLocalService.dart';
import 'package:odc_mobile_project/m_demande/business/service/DemandeNetworkService.dart';
import 'package:odc_mobile_project/m_user/business/service/userLocalService.dart';

class CreerDemandeUseCase {
  DemandeNetworkService network;
  UserLocalService userLocal;

  CreerDemandeUseCase(this.network, this.userLocal);

  Future<String?> run(DemandeRequest data) async {
    String token = await userLocal.getToken();
    var res = await network.creerDemande(data, token);

    return res;
  }
}
