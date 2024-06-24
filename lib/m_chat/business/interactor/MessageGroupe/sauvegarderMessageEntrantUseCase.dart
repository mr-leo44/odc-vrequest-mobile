import 'package:odc_mobile_project/m_chat/business/service/messageLocalService.dart';
import 'package:odc_mobile_project/m_chat/business/service/messageNetworkService.dart';

import '../../model/messageGroupe.dart';

class SauvegarderMessageEntrantUseCase {
  //Les services
  MessageNetworkService network;
  MessageLocalService local;

  SauvegarderMessageEntrantUseCase(this.network, this.local);

  Future<bool> run(MessageGroupe message) async {
    var res = await local.sauvegarderMessageEntrant(message);
    return res;
  }
}
