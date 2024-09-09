
import 'package:odc_mobile_project/m_demande/business/model/Demande.dart';
import 'package:odc_mobile_project/m_demande/business/model/Personn.dart';
import 'package:odc_mobile_project/m_demande/business/service/DemandeNetworkService.dart';

import '../../../../m_user/business/service/userLocalService.dart';

class GetUserByName{
  DemandeNetworkService demande;
  UserLocalService userLocal;

  GetUserByName(this.demande,this.userLocal);

  Future<List<Personn>> run(String name) async{
    var res = await demande.getUserByName(name);
    return res;
  }
}