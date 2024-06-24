
import 'package:odc_mobile_project/m_chat/business/service/messageLocalService.dart';
import '../../model/messageDetails.dart';

class LireLesMessageDetailsLocalUseCase{
  MessageLocalService local;

  LireLesMessageDetailsLocalUseCase(this.local);

  Future<List<MessageDetails>>run(int demandeId) async{
    var resultat= await local.lireLesMessageDetailsLocal(demandeId);
    return resultat;
  }

}