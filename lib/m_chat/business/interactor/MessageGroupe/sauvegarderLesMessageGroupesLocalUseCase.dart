
import 'package:odc_mobile_project/m_chat/business/service/messageLocalService.dart';
import '../../model/messageGroupe.dart';

class SauvegarderLesMessageGroupesLocalUseCase{

    MessageLocalService local;

    SauvegarderLesMessageGroupesLocalUseCase(this.local);

    Future<bool>run(List<MessageGroupe> groupes) async{
        var res= await local.sauvegarderLesMessageGroupesLocal(groupes);
        return res;

    }


}