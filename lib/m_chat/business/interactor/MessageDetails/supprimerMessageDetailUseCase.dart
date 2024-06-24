
import 'package:odc_mobile_project/m_chat/business/service/messageLocalService.dart';
import 'package:odc_mobile_project/m_chat/business/service/messageNetworkService.dart';

class SupprimerMessageDetailUseCase{
      //Services
      MessageNetworkService network;
      MessageLocalService local;

      SupprimerMessageDetailUseCase(this.network, this.local);
      //Fonction run
      Future<bool>run(int messageDetailId) async{
         var res =await network.supprimerMessageDetail(messageDetailId);
         return res;
      }



}