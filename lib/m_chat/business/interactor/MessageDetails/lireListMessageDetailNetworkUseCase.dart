import 'package:odc_mobile_project/m_chat/business/model/messageDetails.dart';
import 'package:odc_mobile_project/m_chat/business/service/messageNetworkService.dart';
import '../../../../m_user/business/service/userLocalService.dart';

class LireListMessageDetailNetworkUseCase{
  MessageNetworkService network;
  UserLocalService user;

  LireListMessageDetailNetworkUseCase(this.network,this.user);

  Future<List<MessageDetails>>run(String Token, int groupId)async{
    var Token= await user.getToken();
    return network.lireListMessageDetailNetwork(Token, groupId);
  }

}