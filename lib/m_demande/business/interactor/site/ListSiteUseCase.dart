import 'package:odc_mobile_project/m_demande/business/model/Site.dart';
import 'package:odc_mobile_project/m_demande/business/service/DemandeLocalService.dart';
import 'package:odc_mobile_project/m_demande/business/service/DemandeNetworkService.dart';
import 'package:odc_mobile_project/m_user/business/service/userLocalService.dart';

class ListSiteUseCase {
  DemandeNetworkService network;
  UserLocalService userLocal;

  ListSiteUseCase(this.network, this.userLocal);

  Future<List<Site?>> run() async {
    String token = await userLocal.getToken();
    var res = await network.listSite(token);
    return res;
  }
}
