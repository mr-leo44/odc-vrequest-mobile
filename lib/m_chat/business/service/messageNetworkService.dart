import 'package:odc_mobile_project/m_chat/business/model/ChatModel.dart';
import 'package:odc_mobile_project/m_chat/business/model/ChatUsersModel.dart';
import 'package:odc_mobile_project/m_chat/business/model/creerMessageRequete.dart';
import 'package:odc_mobile_project/m_demande/business/model/Demande.dart';
import 'package:odc_mobile_project/m_user/business/model/User.dart';
import 'package:signals/signals_flutter.dart';

abstract class MessageNetworkService {
  Signal<ChatModel> message = 
    ChatModel.fromJson({}).toSignal();
  Signal<int> isconnected = Signal(0);
  Signal<int> isdeconnected = Signal(0);

  //Fonctions CRUD
  Future<bool> creerMessage(CreerMessageRequete data);
  Future<List<ChatUsersModel>> recupererListMessageGroupe(String token);
  Future<ChatUsersModel> recupererMessageGroupe(int demandeId);
  Future<bool> supprimerMessageDetail(int messageDetailId);
  Future<List<ChatModel>> recupererListMessageDetail(ChatUsersModel data, User? auth);
  Future<void> realTime(User? auth);
  Future<bool> joinRoom(Demande demande, User? auth);
}
