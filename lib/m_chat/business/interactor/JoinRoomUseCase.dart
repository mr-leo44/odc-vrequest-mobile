import 'package:odc_mobile_project/m_chat/business/service/messageNetworkService.dart';
import 'package:odc_mobile_project/m_demande/business/model/Demande.dart';
import 'package:odc_mobile_project/m_user/business/model/User.dart';

class JoinRoomUseCase{
  MessageNetworkService network;

  JoinRoomUseCase(this.network);

  Future<bool> run(Demande demande, User? auth)async{
    return await network.joinRoom(demande, auth);
  }

}