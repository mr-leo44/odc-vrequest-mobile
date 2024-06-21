
import 'package:odc_mobile_project/m_chat/business/model/ChatModel.dart';
import 'package:odc_mobile_project/m_chat/business/model/ChatUsersModel.dart';
import 'package:odc_mobile_project/m_chat/business/model/Passager.dart';
import 'package:odc_mobile_project/m_chat/business/model/creerMessageRequete.dart';
import 'package:odc_mobile_project/m_chat/business/model/messageDetails.dart';
import 'package:odc_mobile_project/m_chat/business/model/messageGroupe.dart';
import 'package:odc_mobile_project/m_demande/business/model/Demande.dart';

abstract class MessageNetworkService{
  //Fonctions CRUD
  Future<bool> creerMessage(CreerMessageRequete data);
  Future<List<ChatUsersModel>> recupererListMessageGroupe(String token);
  Future<ChatUsersModel> recupererMessageGroupe(int demandeId);
  Future<bool> supprimerMessageDetail(int messageDetailId);
  Future<List<ChatModel>> recupererListMessageDetail(ChatUsersModel data);
  Future<Passager> recupererPassagers(ChatUsersModel data);
}