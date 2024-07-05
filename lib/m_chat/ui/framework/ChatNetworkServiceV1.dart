import 'dart:async';
import 'dart:convert';

import 'package:gio/gio.dart' as gio;
import 'package:odc_mobile_project/m_chat/business/model/ChatModel.dart';
import 'package:odc_mobile_project/m_chat/business/model/ChatUsersModel.dart';
import 'package:odc_mobile_project/m_chat/business/model/creerMessageRequete.dart';
import 'package:odc_mobile_project/m_chat/business/service/messageNetworkService.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/Chat/chat_message_type.dart';
import 'package:odc_mobile_project/m_demande/business/model/Demande.dart';
import 'package:odc_mobile_project/m_user/business/model/User.dart';
import 'package:signals/signals_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ChatNetworkServiceV1 implements MessageNetworkService {
  ChatNetworkServiceV1(this.baseURL, this.socket);
  String baseURL;
  Socket socket;
  @override
  Signal<ChatModel> message = Signal(
    ChatModel.fromJson({}),
  );

  @override
  Future<List<ChatUsersModel>> recupererListMessageGroupe(String token) async {
    List<ChatUsersModel> lists = <ChatUsersModel>[];
    var url = this.baseURL + '/api/demandes';

    try {
      var response = await gio.get(url);

      if (((response.statusCode == 200) || (response.statusCode == 201)) &&
          (response.headers["content-type"] == "application/json")) {
        List result = json.decode(response.body);
        var responseFinal = result.map((e) {
          User initiateur = User.fromJson(e["demande"]["initiateur"]);
          User chauffeur = User.fromJson(e["demande"]["chauffeur"]);
          User lastSender = User.fromJson(e["lastSender"]);
          Demande demande = Demande.fromJson({
            "id": e["demande"]["id"],
            "ticket": e["demande"]["ticket"],
            "motif": e["demande"]["motif"],
            "dateDeplacement": e["demande"]["dateDeplacement"],
            "lieuDestination": e["demande"]["lieuDestination"],
            "lieuDepart": e["demande"]["lieuDepart"],
            "status": e["demande"]["status"],
            "longitude": e["demande"]["longitude"].toString(),
            "latitude": e["demande"]["latitude"].toString(),
            "initiateur": initiateur,
            "chauffeur": chauffeur,
            "nbrEtranger": int.parse(e["demande"]["nbrEtranger"]),
            "created_at": e["demande"]["created_at"],
          });
          return ChatUsersModel.fromJson({
            "demande": demande,
            "lastSender": lastSender,
            "lastMessage": e["lastMessage"],
            "isVideo": e["isVideo"],
            "isMessageRead": e["isMessageRead"],
            "time": e["time"],
            "unread": e["unread"],
          });
        }).toList();
        lists = responseFinal;
      }
    } catch (e) {
      print(e);
    }

    return Future.value(lists);
  }

  @override
  Future<ChatUsersModel> recupererMessageGroupe(int demandeId) async {
    List<ChatUsersModel> listMessages =
        await recupererListMessageGroupe("bjhfdf");
    Iterable<ChatUsersModel> result =
        listMessages.where((x) => x.demande.id == demandeId);
    return result.single;
  }

  @override
  Future<List<ChatModel>> recupererListMessageDetail(
      ChatUsersModel data) async {
    List<ChatModel> lists = <ChatModel>[];
    var url = this.baseURL + '/api/messages';

    try {
      var response = await gio.get(url,
          queryParameters: {"demande_id": data.demande.id.toString()});

      if (((response.statusCode == 200) || (response.statusCode == 201)) &&
          (response.headers["content-type"] == "application/json")) {
        List result = json.decode(response.body);
        var responseFinal = result.map((e) {
          User user = User.fromJson(e["user"]);
          return ChatModel.fromJson({
            "user": user,
            "contenu": e["contenu"],
            "type": (user.id == 1)
                ? ChatMessageType.sent
                : ChatMessageType.received,
            "time": DateTime.parse(e["time"]) ,
          });
        }).toList();
        lists = responseFinal;
      }
    } catch (e) {
      print(e);
    }

    return Future.value(lists);
  }

  @override
  Future<bool> creerMessage(CreerMessageRequete data) async {
    bool added = false;

    var url = this.baseURL + '/api/messages';
    var param = {
      "user_id": data.user.id.toString(),
      "contenu": data.contenu,
      "message_groupe_id": data.demande.id.toString(),
    };

    try {
      var response = await gio.post(url, body: param);

      if (((response.statusCode == 200) || (response.statusCode == 201)) &&
          (response.headers["content-type"] == "application/json")) {
        var result = json.decode(response.body);
        added = result["added"];
      }

      if (socket.connected) {
        print("Socket connected");
        socket.emit('test', 'testSendMsg');

        var donnees = {
          "user": data.user,
          "contenu": data.contenu,
          "demande": data.demande.id,
        };

        socket.emit('joinRoom', donnees["demande"].toString());
        socket.emit('createMessage', donnees);
      } else {
        print("Socket not connected");
      }
    } catch (e) {
      print(e);
    }

    return Future.value(added);
  }

  @override
  Future<bool> supprimerMessageDetail(int messageDetailId) {
    // TODO: implement supprimerMessageDetail
    throw UnimplementedError();
  }

  @override
  Future<void> realTime() async {
    if (socket.connected) {
      print("Socket connected");

      socket.emit('test', 'testReceiveMsg');
      socket.on('sendMessage', (resp) {
        User user = User.fromJson(resp["user"]);
        message.value = ChatModel.fromJson({
          "user": user,
          "contenu": resp["contenu"],
          "type": (user.id == 1)
              ? ChatMessageType.sent
              : ChatMessageType.received,
          "time": DateTime.now(),
        });
      });
    } else {
      print("Socket not connected");
    }
  }
}
