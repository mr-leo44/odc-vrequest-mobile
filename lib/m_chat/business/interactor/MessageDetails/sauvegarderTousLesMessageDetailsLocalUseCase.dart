
import 'package:odc_mobile_project/m_chat/business/service/messageLocalService.dart';
import '../../model/messageDetails.dart';

class SauvegarderTousLesMessageDetailsLocalUseCase{

    MessageLocalService local;

    SauvegarderTousLesMessageDetailsLocalUseCase(this.local);

    Future<bool>run(int demandeId,List<MessageDetails> message) async{
        var resultat = await local.sauvegarderTousLesMessageDetailsLocal(demandeId, message);
        return resultat;
    }

}