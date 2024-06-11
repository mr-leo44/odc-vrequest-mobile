import 'package:odc_mobile_project/m_demande/business/model/Demande.dart';
import 'package:odc_mobile_project/m_demande/business/service/DemandeLocalService.dart';
import 'package:odc_mobile_project/m_demande/business/service/DemandeNetworkService.dart';

import '../../../../m_user/business/service/userLocalService.dart';

class ListDemandeUseCase {
  DemandeNetworkService network;
  UserLocalService userLocal;

  ListDemandeUseCase(this.network, this.userLocal);

  Future<List<Demande?>> run() async {
    String token = await userLocal.getToken();
    var res = await network.listDemande(token);
    return res;
  }
}
