import 'package:odc_mobile_project/m_chat/business/model/ChatModel.dart';
import 'package:odc_mobile_project/m_chat/business/service/messageNetworkService.dart';

class MessageRealTimeUseCase{
  MessageNetworkService network;

  MessageRealTimeUseCase(this.network);

  ChatModel run(){
      return network.message.value;
  }

}