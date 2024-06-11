import 'package:odc_mobile_project/m_chat/business/service/messageLocalService.dart';
import 'package:odc_mobile_project/m_chat/business/service/messageNetworkService.dart';

import '../../model/messageGroupe.dart';

class RecupererListMessageGroupeUseCase{
    MessageNetworkService network;
    MessageLocalService local;

    RecupererListMessageGroupeUseCase(this.network, this.local);

    Future<List<MessageGroupe>>run(int groupId) async{
      var res= await network.recupererListMessageGroupe(groupId);
      return res;
    }

}