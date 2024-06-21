import 'package:odc_mobile_project/m_chat/business/model/ChatUsersModel.dart';
import 'package:odc_mobile_project/m_chat/business/model/Passager.dart';
import 'package:odc_mobile_project/m_chat/business/service/messageLocalService.dart';
import 'package:odc_mobile_project/m_chat/business/service/messageNetworkService.dart';

import '../../model/messageGroupe.dart';

class RecupererPassagersUseCase{
    MessageNetworkService network;
    MessageLocalService local;

    RecupererPassagersUseCase(this.network, this.local);

    Future<Passager>run(ChatUsersModel chatUsersModel) async{
      var res= await network.recupererPassagers(chatUsersModel);
      return res;
    }

}