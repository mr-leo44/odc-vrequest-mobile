
import 'package:odc_mobile_project/m_chat/business/service/messageLocalService.dart';
import 'package:odc_mobile_project/m_chat/business/service/messageNetworkService.dart';

class SauvegarderLesGroupesUseCase{
    //Les Services
    MessageLocalService local;
    MessageNetworkService network;

    SauvegarderLesGroupesUseCase(this.local, this.network);
    //La fonction run
    Future<bool>run(int groupId) async{
      var res= await local.sauvegarderLesGroupes(groupId);
      return res;

    }


}