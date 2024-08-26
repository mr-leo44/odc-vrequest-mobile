
import 'package:odc_mobile_project/m_demande/business/model/Demande.dart';
import 'package:odc_mobile_project/m_demande/business/service/DemandeNetworkService.dart';

import '../../../../m_user/business/service/userLocalService.dart';

class GetDemandeTraiteUseCase{
  DemandeNetworkService demande;
  UserLocalService userLocal;

  GetDemandeTraiteUseCase(this.demande,this.userLocal);

  Future<List<Demande>> run () async{
    var user = await userLocal.getUser();
    var id = user?.id;
    var res;
    if(id != null){
      res = await demande.getDemandeTraite(id);
    }


    return res;
  }
}