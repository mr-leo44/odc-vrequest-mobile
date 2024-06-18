import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:odc_mobile_project/chat/ui/pages/Chat/ChatModel.dart';
import 'package:odc_mobile_project/chat/ui/pages/Chat/ChatState.dart';
import 'package:odc_mobile_project/chat/ui/pages/Chat/chat_message_type.dart';
import 'package:odc_mobile_project/chat/ui/pages/ChatList/ChatUsersModel.dart';

part "ChatCtrl.g.dart";

@riverpod
class ChatCtrl extends _$ChatCtrl {
  late ChatUsersModel chatUsers ;
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

  @override
  ChatState build() {
    this.chatUsers = getChatUsers();
    return ChatState(chatUsers: chatUsers);
  }

  ChatUsersModel getChatUsers() {
    return ChatUsersModel(
      avatar: 'assets/images/avatar.jpeg',
      ticket: 'Power',
      lastSender: 'Ghost',
      lastMessage: '',
      isVideo: true,
      isMessageRead: false,
      time: 'Jan 12',
      unread: 2,
    );
  }

  void getList() async {
    state = state.copyWith(isLoading: true, chatUsers: this.chatUsers);
    Future.delayed(Duration(minutes: 2));
    state = state.copyWith(isLoading: false, chatList: this.chatList, chatUsers: this.chatUsers);
  }

  void addMessage(String text){
    state = state.copyWith(isLoading: true, chatUsers: this.chatUsers);
    //this.chatList.insert(0, ChatModel.sent(message: text));
    this.chatList.add(ChatModel.sent(message: text));
    this.chatList.reversed.toList();
    Future.delayed(Duration(minutes: 1));
    state = state.copyWith(isLoading: false, chatList: this.chatList, chatUsers: this.chatUsers);
  }
}
