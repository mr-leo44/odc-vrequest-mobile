
import 'package:odc_mobile_project/m_chat/business/service/messageLocalService.dart';
import 'package:odc_mobile_project/m_chat/business/service/messageNetworkService.dart';

import '../../model/messageDetails.dart';

class LireLesMessagesUseCase{
    //les Services
    MessageNetworkService network;
    MessageLocalService local;

    LireLesMessagesUseCase(this.network,this.local);

    //La fonction run
    Future<List<MessageDetails>>run(int groupId) async{
        var res = await local.lireLesMessages(groupId);
        return res;
    }


}