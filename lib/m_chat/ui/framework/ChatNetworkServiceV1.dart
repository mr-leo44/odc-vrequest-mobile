import 'package:odc_mobile_project/m_chat/business/model/ChatModel.dart';
import 'package:odc_mobile_project/m_chat/business/model/ChatUsersModel.dart';
import 'package:odc_mobile_project/m_chat/business/model/DemandeChat.dart';
import 'package:odc_mobile_project/m_chat/business/model/creerMessageRequete.dart';
import 'package:odc_mobile_project/m_chat/business/model/messageDetails.dart';
import 'package:odc_mobile_project/m_chat/business/model/messageGroupe.dart';
import 'package:odc_mobile_project/m_chat/business/service/messageNetworkService.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/Chat/chat_message_type.dart';
import 'package:odc_mobile_project/m_user/business/model/User.dart';

class ChatNetworkServiceV1 implements MessageNetworkService {
  ChatNetworkServiceV1(this.baseURL);
  String baseURL;

  List<ChatUsersModel> chatUsers = [
    ChatUsersModel(
      demande: DemandeChat(
        id: 1,
        ticket: "bhjwsdsf",
        dateDeplacement: "12/02/2024",
        motif: "depot courrier",
        lieuDestination: "Matadi",
        lieuDepart: "Kinshasa",
        status: "En attente",
        longitude: "349888",
        latitude: "-2898374",
        initiateur: User(
          id: 1,
          name: "Bap Mutemba",
          emailVerifiedAt: DateTime(DateTime.august),
          createdAt: DateTime(DateTime.august),
          updatedAt: DateTime(DateTime.august),
        ),
        chauffeur: User(
          id: 2,
          name: "Pitshou",
          emailVerifiedAt: DateTime(DateTime.august),
          createdAt: DateTime(DateTime.august),
          updatedAt: DateTime(DateTime.august),
        ),
        nbrEtranger: 2,
        createdAt: "04/02/2024",
      ),
      lastSender: User(
        id: 1,
        name: "Bap Mutemba",
        emailVerifiedAt: DateTime(DateTime.august),
        createdAt: DateTime(DateTime.august),
        updatedAt: DateTime(DateTime.august),
      ),
      lastMessage: 'CamekvhjkbjlnkkjhbvmkhvDodkfnjdgjhcfggbjhnkmljnbhgvcfhj',
      isVideo: false,
      isMessageRead: true,
      time: '20:18',
      unread: 0,
    ),
    ChatUsersModel(
      demande: DemandeChat(
        id: 2,
        ticket: "Power",
        dateDeplacement: "12/03/2024",
        motif: "tour",
        lieuDestination: "Belgique",
        lieuDepart: "Equateur",
        status: "En cours",
        longitude: "349888",
        latitude: "-2898374",
        initiateur: User(
          id: 3,
          name: "Ghost",
          emailVerifiedAt: DateTime(DateTime.august),
          createdAt: DateTime(DateTime.august),
          updatedAt: DateTime(DateTime.august),
        ),
        chauffeur: User(
          id: 4,
          name: "Papy",
          emailVerifiedAt: DateTime(DateTime.august),
          createdAt: DateTime(DateTime.august),
          updatedAt: DateTime(DateTime.august),
        ),
        nbrEtranger: 2,
        createdAt: "04/03/2024",
      ),
      lastSender: User(
        id: 3,
        name: "Ghost",
        emailVerifiedAt: DateTime(DateTime.august),
        createdAt: DateTime(DateTime.august),
        updatedAt: DateTime(DateTime.august),
      ),
      lastMessage: '',
      isVideo: true,
      isMessageRead: false,
      time: 'Mars 12',
      unread: 2,
    ),
    ChatUsersModel(
      demande: DemandeChat(
        id: 3,
        ticket: "d50Centd97",
        dateDeplacement: "12/04/2024",
        motif: "courses",
        lieuDestination: "Matonge",
        lieuDepart: "Macampagne",
        status: "Termine",
        longitude: "349888",
        latitude: "-2898374",
        initiateur: User(
          id: 5,
          name: "50 Cent",
          emailVerifiedAt: DateTime(DateTime.august),
          createdAt: DateTime(DateTime.august),
          updatedAt: DateTime(DateTime.august),
        ),
        chauffeur: User(
          id: 6,
          name: "Richard",
          emailVerifiedAt: DateTime(DateTime.august),
          createdAt: DateTime(DateTime.august),
          updatedAt: DateTime(DateTime.august),
        ),
        nbrEtranger: 1,
        createdAt: "04/04/2024",
      ),
      lastSender: User(
        id: 5,
        name: "Richard",
        emailVerifiedAt: DateTime(DateTime.august),
        createdAt: DateTime(DateTime.august),
        updatedAt: DateTime(DateTime.august),
      ),
      lastMessage: '',
      isVideo: false,
      isMessageRead: false,
      time: 'Yesterday',
      unread: 1,
    ),
  ];

  List<ChatModel> chatList = [
    ChatModel(
      user: User(
        id: 5,
        name: "Richard",
        emailVerifiedAt: DateTime(DateTime.august),
        createdAt: DateTime(DateTime.august),
        updatedAt: DateTime(DateTime.august),
      ),
      message: "Hello!",
      type: ChatMessageType.received,
      time: DateTime.now().subtract(const Duration(minutes: 15)),
    ),
    ChatModel(
      user: User(
        id: 1,
        name: "Bap Mutemba",
        emailVerifiedAt: DateTime(DateTime.august),
        createdAt: DateTime(DateTime.august),
        updatedAt: DateTime(DateTime.august),
      ),
      message: "Hey",
      type: ChatMessageType.sent,
      time: DateTime.now().subtract(const Duration(minutes: 15)),
    ),
    ChatModel(
      user: User(
        id: 9,
        name: "Big Boss",
        emailVerifiedAt: DateTime(DateTime.august),
        createdAt: DateTime(DateTime.august),
        updatedAt: DateTime(DateTime.august),
      ),
      message: "Hellooo!",
      type: ChatMessageType.received,
      time: DateTime.now().subtract(const Duration(minutes: 15)),
    ),
    ChatModel(
      user: User(
        id: 1,
        name: "Baptiste Mutemba",
        emailVerifiedAt: DateTime(DateTime.august),
        createdAt: DateTime(DateTime.august),
        updatedAt: DateTime(DateTime.august),
      ),
      message: "Nice to meet you!",
      type: ChatMessageType.sent,
      time: DateTime.now().subtract(const Duration(minutes: 14)),
    ),
    ChatModel(
      user: User(
        id: 9,
        name: "Big Boss",
        emailVerifiedAt: DateTime(DateTime.august),
        createdAt: DateTime(DateTime.august),
        updatedAt: DateTime(DateTime.august),
      ),
      message: "The weather is nice today.",
      type: ChatMessageType.received,
      time: DateTime.now().subtract(const Duration(minutes: 13)),
    ),
    ChatModel(
      user: User(
        id: 5,
        name: "Richard",
        emailVerifiedAt: DateTime(DateTime.august),
        createdAt: DateTime(DateTime.august),
        updatedAt: DateTime(DateTime.august),
      ),
      message: "Yes, it's a great day to go out.",
      type: ChatMessageType.received,
      time: DateTime.now().subtract(const Duration(minutes: 12)),
    ),
    ChatModel(
      user: User(
        id: 1,
        name: "Bap Mutemba",
        emailVerifiedAt: DateTime(DateTime.august),
        createdAt: DateTime(DateTime.august),
        updatedAt: DateTime(DateTime.august),
      ),
      message: "Have a nice day!",
      type: ChatMessageType.sent,
      time: DateTime.now().subtract(const Duration(minutes: 11)),
    ),
    ChatModel(
      user: User(
        id: 5,
        name: "Richard",
        emailVerifiedAt: DateTime(DateTime.august),
        createdAt: DateTime(DateTime.august),
        updatedAt: DateTime(DateTime.august),
      ),
      message: "What are your plans for the weekend?",
      type: ChatMessageType.received,
      time: DateTime.now().subtract(const Duration(minutes: 10)),
    ),
    ChatModel(
      user: User(
        id: 1,
        name: "Bap Mutemba",
        emailVerifiedAt: DateTime(DateTime.august),
        createdAt: DateTime(DateTime.august),
        updatedAt: DateTime(DateTime.august),
      ),
      message: "I'm planning to go to the beach.",
      type: ChatMessageType.sent,
      time: DateTime.now().subtract(const Duration(minutes: 9)),
    ),
    ChatModel(
      user: User(
        id: 9,
        name: "Big Boss",
        emailVerifiedAt: DateTime(DateTime.august),
        createdAt: DateTime(DateTime.august),
        updatedAt: DateTime(DateTime.august),
      ),
      message: "That sounds fun!",
      type: ChatMessageType.received,
      time: DateTime.now().subtract(const Duration(minutes: 8)),
    ),
    ChatModel(
      user: User(
        id: 1,
        name: "Bap Mutemba",
        emailVerifiedAt: DateTime(DateTime.august),
        createdAt: DateTime(DateTime.august),
        updatedAt: DateTime(DateTime.august),
      ),
      message: "Do you want to come with me?",
      type: ChatMessageType.sent,
      time: DateTime.now().subtract(const Duration(minutes: 7)),
    ),
    ChatModel(
      user: User(
        id: 9,
        name: "Big Boss",
        emailVerifiedAt: DateTime(DateTime.august),
        createdAt: DateTime(DateTime.august),
        updatedAt: DateTime(DateTime.august),
      ),
      message: "Sure, I'd love to!",
      type: ChatMessageType.received,
      time: DateTime.now().subtract(const Duration(minutes: 6)),
    ),
    ChatModel(
      user: User(
        id: 1,
        name: "Bap Mutemba",
        emailVerifiedAt: DateTime(DateTime.august),
        createdAt: DateTime(DateTime.august),
        updatedAt: DateTime(DateTime.august),
      ),
      message: "What time should we meet?",
      type: ChatMessageType.sent,
      time: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
    ChatModel(
      user: User(
        id: 9,
        name: "Big Boss",
        emailVerifiedAt: DateTime(DateTime.august),
        createdAt: DateTime(DateTime.august),
        updatedAt: DateTime(DateTime.august),
      ),
      message: "Let's meet at 10am.",
      type: ChatMessageType.received,
      time: DateTime.now().subtract(const Duration(minutes: 4)),
    ),
    ChatModel(
      user: User(
        id: 1,
        name: "Bap Mutemba",
        emailVerifiedAt: DateTime(DateTime.august),
        createdAt: DateTime(DateTime.august),
        updatedAt: DateTime(DateTime.august),
      ),
      message: "Sounds good to me!",
      type: ChatMessageType.sent,
      time: DateTime.now().subtract(const Duration(minutes: 3)),
    ),
    ChatModel(
      user: User(
        id: 9,
        name: "Big Boss",
        emailVerifiedAt: DateTime(DateTime.august),
        createdAt: DateTime(DateTime.august),
        updatedAt: DateTime(DateTime.august),
      ),
      message: "See you then!",
      type: ChatMessageType.received,
      time: DateTime.now().subtract(const Duration(minutes: 2)),
    ),
    ChatModel(
      user: User(
        id: 5,
        name: "Richard",
        emailVerifiedAt: DateTime(DateTime.august),
        createdAt: DateTime(DateTime.august),
        updatedAt: DateTime(DateTime.august),
      ),
      message: "Let's go!",
      type: ChatMessageType.received,
      time: DateTime.now(),
    ),
    // ChatModel(
    //   message: "Bye!",
    //   type: ChatMessageType.received,
    //   time: DateTime.now().subtract(const Duration(minutes: 1)),
    // ),
    // ChatModel(
    //   message: "How was your weekend?",
    //   type: ChatMessageType.received,
    //   time: DateTime.now().subtract(const Duration(minutes: 1)),
    // ),
    // ChatModel(
    //   message: "It was great! The beach was awesome.",
    //   type: ChatMessageType.sent,
    //   time: DateTime.now(),
    // ),
    // ChatModel(
    //   message: "I'm glad to hear that!",
    //   type: ChatMessageType.received,
    //   time: DateTime.now(),
    // ),
    // ChatModel(
    //   message: "We should do that again sometime.",
    //   type: ChatMessageType.sent,
    //   time: DateTime.now(),
    // ),
    // ChatModel(
    //   message: "Definitely!",
    //   type: ChatMessageType.received,
    //   time: DateTime.now(),
    // ),
  ];

  @override
  Future<List<ChatUsersModel>> recupererListMessageGroupe(String token) {
    return Future.value(this.chatUsers);
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
    return Future.value(this.chatList);
  }

  @override
  Future<bool> creerMessage(CreerMessageRequete data) async {
    ChatUsersModel chatUsersModel =
        await recupererMessageGroupe(data.demande.id);
    List<ChatModel> listMessages =
        await recupererListMessageDetail(chatUsersModel);
    listMessages.add(ChatModel.sent(user: data.user, message: data.contenu));
    listMessages.reversed.toList();

    return Future.value(true);
  }

  @override
  Future<bool> supprimerMessageDetail(int messageDetailId) {
    // TODO: implement supprimerMessageDetail
    throw UnimplementedError();
  }
}
