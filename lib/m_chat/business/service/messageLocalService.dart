import 'package:odc_mobile_project/m_chat/business/model/messageDetails.dart';

import '../model/messageGroupe.dart';

abstract class MessageLocalService{
  Future<bool>sauvegarderMessageDetailEntrantLocal(int demandeId,MessageDetails message);
  Future<List<MessageDetails>>lireLesMessageDetailsLocal(int demandeId);
  Future<bool>sauvegarderTousLesMessageDetailsLocal(int demandeId,List<MessageDetails> message);
  Future<bool>sauvegarderLesMessageGroupesLocal(List<MessageGroupe> groupes);
  Future<List<MessageGroupe>>lireLesMessageGroupesLocal();

}