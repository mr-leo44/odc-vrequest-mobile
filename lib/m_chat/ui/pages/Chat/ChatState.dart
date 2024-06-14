import 'package:vrequest_mobile_test/chat/ui/pages/Chat/Chat.dart';
import 'package:vrequest_mobile_test/chat/ui/pages/ChatList/ChatUsersModel.dart';

class ChatState {
  bool isLoading;
  List<Chat> chatList = [];
  ChatUsersModel chatUsers ;


  ChatState({
    this.isLoading = false,
    this.chatList = const [],
    required this.chatUsers,
  });

  ChatState copyWith({
    bool? isLoading,
    List<Chat>? chatList,
    required ChatUsersModel chatUsers
  }) =>
      ChatState(
        isLoading: isLoading ?? this.isLoading,
        chatList: chatList ?? this.chatList,
        chatUsers: chatUsers ?? this.chatUsers,
      );
}