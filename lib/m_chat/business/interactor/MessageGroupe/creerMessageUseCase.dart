import 'package:odc_mobile_project/m_chat/business/service/messageNetworkService.dart';
import 'package:odc_mobile_project/m_user/business/service/userNetworkService.dart';

import '../../model/creerMessageRequete.dart';
import '../../service/messageLocalService.dart';

class CreerMessageUseCase {
  UserNetworkService user;
  MessageNetworkService network;
  MessageLocalService local;

  CreerMessageUseCase(this.user, this.network, this.local);

  Future<bool> run(CreerMessageRequete data) async {
    var res = await network.creerMessage(data);
    return res;
  }
}
