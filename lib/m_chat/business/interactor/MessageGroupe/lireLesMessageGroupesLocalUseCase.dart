
import 'package:odc_mobile_project/m_chat/business/service/messageLocalService.dart';
import '../../model/messageGroupe.dart';

class LireLesMessageGroupesLocalUseCase{

  MessageLocalService local;

  LireLesMessageGroupesLocalUseCase(this.local);

  Future<List<MessageGroupe>>run() async{
    var res= await local.lireLesMessageGroupesLocal();
    return res;
  }



}