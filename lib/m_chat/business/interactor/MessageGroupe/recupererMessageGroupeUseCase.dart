import 'package:odc_mobile_project/m_chat/business/model/ChatUsersModel.dart';
import 'package:odc_mobile_project/m_chat/business/service/messageLocalService.dart';
import 'package:odc_mobile_project/m_chat/business/service/messageNetworkService.dart';

import '../../model/messageGroupe.dart';

class RecupererMessageGroupeUseCase{
    MessageNetworkService network;
    MessageLocalService local;

    RecupererMessageGroupeUseCase(this.network, this.local);

    Future<ChatUsersModel>run(int demandeId) async{
      var res= await network.recupererMessageGroupe(demandeId);
      return res;
    }

}