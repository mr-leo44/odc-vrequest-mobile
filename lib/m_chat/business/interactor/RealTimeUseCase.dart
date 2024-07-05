import 'package:odc_mobile_project/m_chat/business/model/ChatModel.dart';
import 'package:odc_mobile_project/m_chat/business/model/ChatUsersModel.dart';
import 'package:odc_mobile_project/m_chat/business/service/messageLocalService.dart';
import 'package:odc_mobile_project/m_chat/business/service/messageNetworkService.dart';
import 'package:odc_mobile_project/m_user/business/model/User.dart';
import 'package:signals/signals_flutter.dart';

class RealTimeUseCase{
  MessageNetworkService network;

  RealTimeUseCase(this.network);

  Future<void>run()async{
      await network.realTime();
  }

}