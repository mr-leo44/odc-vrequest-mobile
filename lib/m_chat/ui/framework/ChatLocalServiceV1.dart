import 'package:odc_mobile_project/m_chat/business/model/messageDetails.dart';
import 'package:odc_mobile_project/m_chat/business/model/messageGroupe.dart';
import 'package:odc_mobile_project/m_chat/business/service/messageLocalService.dart';

class ChatLocalServiceV1 implements MessageLocalService {
  ChatLocalServiceV1(this.baseURL);
  String baseURL ;

  @override
  Future<List<MessageGroupe>> lireLesGroupes(int groupId) {
    // TODO: implement lireLesGroupes
    throw UnimplementedError();
  }

  @override
  Future<List<MessageDetails>> lireLesMessages(int groupId) {
    // TODO: implement lireLesMessages
    throw UnimplementedError();
  }

  @override
  Future<bool> sauvegarderLesGroupes(int groupId) {
    // TODO: implement sauvegarderLesGroupes
    throw UnimplementedError();
  }

  @override
  Future<bool> sauvegarderMessageEntrant(MessageGroupe message) {
    // TODO: implement sauvegarderMessageEntrant
    throw UnimplementedError();
  }

  @override
  Future<bool> sauvegarderTousLesMessages(List<MessageGroupe> message) {
    // TODO: implement sauvegarderTousLesMessages
    throw UnimplementedError();
  }

}