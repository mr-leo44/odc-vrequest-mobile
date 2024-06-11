import 'package:odc_mobile_project/m_demande/business/model/Site.dart';
import 'package:odc_mobile_project/m_demande/business/service/DemandeLocalService.dart';
import 'package:odc_mobile_project/m_demande/business/service/DemandeNetworkService.dart';

class ListSiteUseCase {
  DemandeNetworkService network;
  Demandelocalservice locale;

  ListSiteUseCase(this.network, this.locale);

  Future<List<Site?>> run() async {
    var res = await network.listSite();
    return res;
  }
}
