import 'package:odc_mobile_project/m_chat/business/service/messageNetworkService.dart';

class IsConnectedUseCase{
  MessageNetworkService network;

  IsConnectedUseCase(this.network);

  int run(){
      return network.isconnected.value;
  }

}