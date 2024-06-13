import 'package:odc_mobile_project/m_chat/business/service/messageLocalService.dart';
import '../../model/messageDetails.dart';

class SauvegarderMessageDetailEntrantLocalUseCase {
    MessageLocalService local;

    SauvegarderMessageDetailEntrantLocalUseCase(this.local);

    Future<bool> run(int demandeId,MessageDetails message) async {
        var resultat = await local.sauvegarderMessageDetailEntrantLocal(demandeId, message);
        return resultat;
    }
}
