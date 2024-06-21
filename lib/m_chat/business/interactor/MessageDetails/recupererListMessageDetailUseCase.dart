import 'package:odc_mobile_project/m_chat/business/model/ChatModel.dart';
import 'package:odc_mobile_project/m_chat/business/model/ChatUsersModel.dart';
import 'package:odc_mobile_project/m_chat/business/model/messageDetails.dart';
import 'package:odc_mobile_project/m_chat/business/service/messageLocalService.dart';
import 'package:odc_mobile_project/m_chat/business/service/messageNetworkService.dart';

import '../../model/messageGroupe.dart';

class RecupererListMessageDetailUseCase{
  MessageNetworkService network;
  MessageLocalService local;

  RecupererListMessageDetailUseCase(this.network,this.local);

  Future<List<ChatModel>>run(ChatUsersModel chatUsersModel)async{
      var res= await network.recupererListMessageDetail(chatUsersModel);
      return res;
  }

}