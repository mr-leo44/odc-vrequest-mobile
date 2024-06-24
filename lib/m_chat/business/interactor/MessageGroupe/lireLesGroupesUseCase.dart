
import 'package:odc_mobile_project/m_chat/business/service/messageLocalService.dart';
import 'package:odc_mobile_project/m_chat/business/service/messageNetworkService.dart';

import '../../model/messageGroupe.dart';

class LireLesGroupesUseCase{
    //Les Services
    MessageNetworkService network;
    MessageLocalService local;

    LireLesGroupesUseCase(this.network, this.local);
    //La fonction run
    Future<List<MessageGroupe>>run(int groupId) async{
        var res= await local.lireLesGroupes(groupId);
        return res;
    }



}