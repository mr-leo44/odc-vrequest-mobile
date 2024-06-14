import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vrequest_mobile_test/chat/ui/pages/Chat/Chat.dart';
import 'package:vrequest_mobile_test/chat/ui/pages/Chat/ChatState.dart';
import 'package:vrequest_mobile_test/chat/ui/pages/Chat/chat_message_type.dart';
import 'package:vrequest_mobile_test/chat/ui/pages/ChatList/ChatUsersModel.dart';

part "ChatCtrl.g.dart";

@riverpod
class ChatCtrl extends _$ChatCtrl {
  late ChatUsersModel chatUsers ;
  List<Chat> chatList = [
      Chat(
        message: "Hello!",
        type: ChatMessageType.sent,
        time: DateTime.now().subtract(const Duration(minutes: 15)),
      ),
      Chat(
        message: "Nice to meet you!",
        type: ChatMessageType.received,
        time: DateTime.now().subtract(const Duration(minutes: 14)),
      ),
      Chat(
        message: "The weather is nice today.",
        type: ChatMessageType.sent,
        time: DateTime.now().subtract(const Duration(minutes: 13)),
      ),
      Chat(
        message: "Yes, it's a great day to go out.",
        type: ChatMessageType.received,
        time: DateTime.now().subtract(const Duration(minutes: 12)),
      ),
      Chat(
        message: "Have a nice day!",
        type: ChatMessageType.sent,
        time: DateTime.now().subtract(const Duration(minutes: 11)),
      ),
      Chat(
        message: "What are your plans for the weekend?",
        type: ChatMessageType.received,
        time: DateTime.now().subtract(const Duration(minutes: 10)),
      ),
      Chat(
        message: "I'm planning to go to the beach.",
        type: ChatMessageType.sent,
        time: DateTime.now().subtract(const Duration(minutes: 9)),
      ),
      Chat(
        message: "That sounds fun!",
        type: ChatMessageType.received,
        time: DateTime.now().subtract(const Duration(minutes: 8)),
      ),
      Chat(
        message: "Do you want to come with me?",
        type: ChatMessageType.sent,
        time: DateTime.now().subtract(const Duration(minutes: 7)),
      ),
      Chat(
        message: "Sure, I'd love to!",
        type: ChatMessageType.received,
        time: DateTime.now().subtract(const Duration(minutes: 6)),
      ),
      Chat(
        message: "What time should we meet?",
        type: ChatMessageType.received,
        time: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
      Chat(
        message: "Let's meet at 10am.",
        type: ChatMessageType.sent,
        time: DateTime.now().subtract(const Duration(minutes: 4)),
      ),
      Chat(
        message: "Sounds good to me!",
        type: ChatMessageType.received,
        time: DateTime.now().subtract(const Duration(minutes: 3)),
      ),
      Chat(
        message: "See you then!",
        type: ChatMessageType.sent,
        time: DateTime.now().subtract(const Duration(minutes: 2)),
      ),
      Chat(
        message: "Bye!",
        type: ChatMessageType.received,
        time: DateTime.now().subtract(const Duration(minutes: 1)),
      ),
      Chat(
        message: "How was your weekend?",
        type: ChatMessageType.received,
        time: DateTime.now().subtract(const Duration(minutes: 1)),
      ),
      Chat(
        message: "It was great! The beach was awesome.",
        type: ChatMessageType.sent,
        time: DateTime.now(),
      ),
      Chat(
        message: "I'm glad to hear that!",
        type: ChatMessageType.received,
        time: DateTime.now(),
      ),
      Chat(
        message: "We should do that again sometime.",
        type: ChatMessageType.sent,
        time: DateTime.now(),
      ),
      Chat(
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
    //this.chatList.insert(0, Chat.sent(message: text));
    this.chatList.add(Chat.sent(message: text));
    this.chatList.reversed.toList();
    Future.delayed(Duration(minutes: 1));
    state = state.copyWith(isLoading: false, chatList: this.chatList, chatUsers: this.chatUsers);
  }
}
