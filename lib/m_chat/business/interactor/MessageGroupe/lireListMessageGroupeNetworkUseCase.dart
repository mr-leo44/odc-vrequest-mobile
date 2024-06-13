import 'package:odc_mobile_project/m_chat/business/service/messageNetworkService.dart';

import '../../../../m_user/business/service/userLocalService.dart';
import '../../model/messageGroupe.dart';

class LireListMessageGroupeNetworkUseCase{
  MessageNetworkService network;
  UserLocalService user;

  LireListMessageGroupeNetworkUseCase(this.network, this.user);

  Future<List<MessageGroupe>>run(String token) async{
    var token= await user.getToken();
    return network.lireListMessageGroupeNetwork(token);
  }

}