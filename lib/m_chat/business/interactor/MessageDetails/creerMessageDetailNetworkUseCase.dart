import 'package:odc_mobile_project/m_chat/business/model/creerMessageRequete.dart';
import 'package:odc_mobile_project/m_chat/business/model/messageDetails.dart';
import 'package:odc_mobile_project/m_chat/business/service/messageNetworkService.dart';
import 'package:odc_mobile_project/m_user/business/service/userLocalService.dart';
import '../../service/messageLocalService.dart';

class CreerMessageDetailNetworkUseCase {
  UserLocalService user;
  MessageNetworkService network;
  MessageLocalService local;

  CreerMessageDetailNetworkUseCase(this.user, this.network, this.local);

  Future<MessageDetails?> run(String token, CreerMessageRequete data, int demandeId) async {
    var token= await user.getToken();
    var resultat=await network.creerMessageDetailNetwork(token, data);


    if(resultat!=null){
      local.sauvegarderMessageDetailEntrantLocal(demandeId,resultat);
    }

    return resultat;
  }
}
