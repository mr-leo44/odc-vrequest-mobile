
import 'package:odc_mobile_project/m_chat/business/model/messageDetails.dart';

import '../model/messageGroupe.dart';

abstract class MessageLocalService{
  Future<bool>sauvegarderMessageEntrant(MessageGroupe message);
  Future<List<MessageDetails>>lireLesMessages(int groupId);
  Future<bool>sauvegarderTousLesMessages(List<MessageGroupe> message);
  Future<bool>sauvegarderLesGroupes(int groupId);
  Future<List<MessageGroupe>>lireLesGroupes(int groupId);

}