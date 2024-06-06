
import 'package:odc_mobile_project/m_chat/business/model/corpMessage.dart';
import 'package:odc_mobile_project/m_chat/business/model/messageDetails.dart';
import 'package:odc_mobile_project/m_chat/business/model/messageGroupe.dart';

abstract class MessageNetworkService{
  //Fonctions CRUD
  Future<bool> creerMessage(CorpMessage data);
  Future<List<MessageGroupe>> recupererListMessageGroupe(int groupId);
  Future<bool> supprimerMessageDetail(int messageDetailId);
  Future<List<MessageDetails>> recupererListMessageDetail(int groupId);
}