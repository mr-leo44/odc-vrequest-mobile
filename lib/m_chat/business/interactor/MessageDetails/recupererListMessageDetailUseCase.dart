import 'package:odc_mobile_project/m_chat/business/model/messageDetails.dart';
import 'package:odc_mobile_project/m_chat/business/service/messageLocalService.dart';
import 'package:odc_mobile_project/m_chat/business/service/messageNetworkService.dart';

import '../../model/messageGroupe.dart';

class RecupererListMessageDetailUseCase{
  MessageNetworkService network;
  MessageLocalService local;

  RecupererListMessageDetailUseCase(this.network,this.local);

  Future<List<MessageDetails>>run(int groupId)async{
      var res= await network.recupererListMessageDetail(groupId);
      return res;
  }

}