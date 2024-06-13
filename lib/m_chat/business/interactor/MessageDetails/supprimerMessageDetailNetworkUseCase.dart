import 'package:odc_mobile_project/m_chat/business/service/messageNetworkService.dart';

import '../../../../m_user/business/service/userLocalService.dart';

class SupprimerMessageDetailNetworkUseCase {
  MessageNetworkService network;
  UserLocalService user;

  SupprimerMessageDetailNetworkUseCase(this.network, this.user);

  Future<bool> run(String Token, int messageDetailId) async {
    var Token = await user.getToken();
    return network.supprimerMessageDetailNetwork(Token, messageDetailId);
  }
}
