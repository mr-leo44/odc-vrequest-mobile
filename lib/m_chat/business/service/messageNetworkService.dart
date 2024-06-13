
import 'package:odc_mobile_project/m_chat/business/model/creerMessageRequete.dart';
import 'package:odc_mobile_project/m_chat/business/model/messageDetails.dart';
import 'package:odc_mobile_project/m_chat/business/model/messageGroupe.dart';

abstract class MessageNetworkService{

  Future<MessageDetails?> creerMessageDetailNetwork(String token,CreerMessageRequete data);
  Future<List<MessageGroupe>> lireListMessageGroupeNetwork(String token);
  Future<bool> supprimerMessageDetailNetwork(String token, int messageDetailId);
  Future<List<MessageDetails>> lireListMessageDetailNetwork(String token, int groupId);
}