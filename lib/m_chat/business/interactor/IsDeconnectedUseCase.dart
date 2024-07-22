import 'package:odc_mobile_project/m_chat/business/service/messageNetworkService.dart';

class IsDeconnectedUseCase{
  MessageNetworkService network;

  IsDeconnectedUseCase(this.network);

  int run(){
      return network.isdeconnected.value;
  }

}