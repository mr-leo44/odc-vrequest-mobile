
import 'package:odc_mobile_project/m_demande/business/service/DemandeNetworkService.dart';

import '../../../../m_user/business/service/userLocalService.dart';

class NombreDemandeUseCase{
  DemandeNetworkService demande;
  UserLocalService userLocal;

  NombreDemandeUseCase(this.demande,this.userLocal);

  Future<Map<String,dynamic>> run () async{
    var user = await userLocal.getUser();
    var id = user?.id;
    var res;
    if(id != null){
      res = await demande.nombreDemande(id);
    }


    return res;
  }
}