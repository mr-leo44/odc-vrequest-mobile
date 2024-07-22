import 'package:odc_mobile_project/m_chat/business/service/messageNetworkService.dart';
import 'package:odc_mobile_project/m_user/business/model/User.dart';

class RealTimeUseCase{
  MessageNetworkService network;

  RealTimeUseCase(this.network);

  Future<void>run(User? auth)async{
      await network.realTime(auth);
  }

}