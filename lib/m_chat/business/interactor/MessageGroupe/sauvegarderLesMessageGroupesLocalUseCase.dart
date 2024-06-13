
import 'package:odc_mobile_project/m_chat/business/service/messageLocalService.dart';
import 'package:odc_mobile_project/m_chat/business/service/messageNetworkService.dart';

import '../../model/messageGroupe.dart';

class SauvegarderTousLesMessagesUseCase{
      // Services
    MessageNetworkService network;
    MessageLocalService local;

    SauvegarderTousLesMessagesUseCase(this.network,this.local);

    Future<bool>run(List<MessageGroupe> message) async{
        var res = await local.sauvegarderTousLesMessages(message);
        return res;

    }

}