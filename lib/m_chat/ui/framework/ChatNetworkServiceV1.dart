import 'package:odc_mobile_project/m_chat/business/model/ChatModel.dart';
import 'package:odc_mobile_project/m_chat/business/model/ChatUsersModel.dart';
import 'package:odc_mobile_project/m_chat/business/model/Passager.dart';
import 'package:odc_mobile_project/m_chat/business/model/creerMessageRequete.dart';
import 'package:odc_mobile_project/m_chat/business/model/messageDetails.dart';
import 'package:odc_mobile_project/m_chat/business/model/messageGroupe.dart';
import 'package:odc_mobile_project/m_chat/business/service/messageNetworkService.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/Chat/chat_message_type.dart';

class ChatNetworkServiceV1 implements MessageNetworkService {
  ChatNetworkServiceV1(this.baseURL);
  String baseURL ;

  List<ChatUsersModel> chatUsers = [
      ChatUsersModel(
        avatar: 'assets/images/avatar.jpeg',
        demandeId: 1,
        ticket: 'Basni76545s',
        lastSender: 'Bap Mutemba',
        lastMessage: 'CamekvhjkbjlnkkjhbvmkhvDodkfnjdgjhcfggbjhnkmljnbhgvcfhj',
        isVideo: false,
        isMessageRead: true,
        time: '20:18',
        unread: 0,
      ),
      ChatUsersModel(
        avatar: 'assets/images/avatar.jpeg',
        demandeId: 2,
        ticket: 'Power',
        lastSender: 'Ghost',
        lastMessage: '',
        isVideo: true,
        isMessageRead: false,
        time: 'Jan 12',
        unread: 2,
      ),
      ChatUsersModel(
        avatar: 'assets/images/avatar.jpeg',
        demandeId: 3,
        ticket: 'd50Centd97',
        lastSender: '50 cent',
        lastMessage: '',
        isVideo: false,
        isMessageRead: false,
        time: 'Yesterday',
        unread: 1,
      ),
    ];

  List<ChatModel> chatList = [
      ChatModel(
        message: "Hello!",
        type: ChatMessageType.sent,
        time: DateTime.now().subtract(const Duration(minutes: 15)),
      ),
      ChatModel(
        message: "Nice to meet you!",
        type: ChatMessageType.received,
        time: DateTime.now().subtract(const Duration(minutes: 14)),
      ),
      ChatModel(
        message: "The weather is nice today.",
        type: ChatMessageType.sent,
        time: DateTime.now().subtract(const Duration(minutes: 13)),
      ),
      ChatModel(
        message: "Yes, it's a great day to go out.",
        type: ChatMessageType.received,
        time: DateTime.now().subtract(const Duration(minutes: 12)),
      ),
      ChatModel(
        message: "Have a nice day!",
        type: ChatMessageType.sent,
        time: DateTime.now().subtract(const Duration(minutes: 11)),
      ),
      ChatModel(
        message: "What are your plans for the weekend?",
        type: ChatMessageType.received,
        time: DateTime.now().subtract(const Duration(minutes: 10)),
      ),
      ChatModel(
        message: "I'm planning to go to the beach.",
        type: ChatMessageType.sent,
        time: DateTime.now().subtract(const Duration(minutes: 9)),
      ),
      ChatModel(
        message: "That sounds fun!",
        type: ChatMessageType.received,
        time: DateTime.now().subtract(const Duration(minutes: 8)),
      ),
      ChatModel(
        message: "Do you want to come with me?",
        type: ChatMessageType.sent,
        time: DateTime.now().subtract(const Duration(minutes: 7)),
      ),
      ChatModel(
        message: "Sure, I'd love to!",
        type: ChatMessageType.received,
        time: DateTime.now().subtract(const Duration(minutes: 6)),
      ),
      ChatModel(
        message: "What time should we meet?",
        type: ChatMessageType.received,
        time: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
      ChatModel(
        message: "Let's meet at 10am.",
        type: ChatMessageType.sent,
        time: DateTime.now().subtract(const Duration(minutes: 4)),
      ),
      ChatModel(
        message: "Sounds good to me!",
        type: ChatMessageType.received,
        time: DateTime.now().subtract(const Duration(minutes: 3)),
      ),
      ChatModel(
        message: "See you then!",
        type: ChatMessageType.sent,
        time: DateTime.now().subtract(const Duration(minutes: 2)),
      ),
      ChatModel(
        message: "Bye!",
        type: ChatMessageType.received,
        time: DateTime.now().subtract(const Duration(minutes: 1)),
      ),
      ChatModel(
        message: "How was your weekend?",
        type: ChatMessageType.received,
        time: DateTime.now().subtract(const Duration(minutes: 1)),
      ),
      ChatModel(
        message: "It was great! The beach was awesome.",
        type: ChatMessageType.sent,
        time: DateTime.now(),
      ),
      ChatModel(
        message: "I'm glad to hear that!",
        type: ChatMessageType.received,
        time: DateTime.now(),
      ),
      ChatModel(
        message: "We should do that again sometime.",
        type: ChatMessageType.sent,
        time: DateTime.now(),
      ),
      ChatModel(
        message: "Definitely!",
        type: ChatMessageType.received,
        time: DateTime.now(),
      ),
    ];

  Passager passagers = Passager(
    initiateur: "Kevin Hart",
    chauffeur: "Atari",
    nbrEtranger: 2,
  );

  @override
  Future<List<ChatUsersModel>> recupererListMessageGroupe(String token) {
    return Future.value(this.chatUsers);
  }

  @override
  Future<ChatUsersModel> recupererMessageGroupe(int demandeId)async {
    List<ChatUsersModel> listMessages = await recupererListMessageGroupe("bjhfdf");
    Iterable<ChatUsersModel> result = listMessages.where((x) => x.demandeId == demandeId);
    return result.single;
  }

  @override
  Future<List<ChatModel>> recupererListMessageDetail(ChatUsersModel data) async {
    return Future.value(this.chatList);
  }
  
  @override
  Future<bool> creerMessage(CreerMessageRequete data) async{
    ChatUsersModel chatUsersModel = await recupererMessageGroupe(data.demandeId);
    List<ChatModel> listMessages = await recupererListMessageDetail(chatUsersModel);
    listMessages.add(ChatModel.sent(message: data.contenu));
    listMessages.reversed.toList();

    return Future.value(true);
  }
  
  @override
  Future<bool> supprimerMessageDetail(int messageDetailId) {
    // TODO: implement supprimerMessageDetail
    throw UnimplementedError();
  }

  @override
  Future<Passager> recupererPassagers(ChatUsersModel data) {
    return Future.value(this.passagers);
  }
}