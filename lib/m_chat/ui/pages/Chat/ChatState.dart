import 'package:odc_mobile_project/chat/ui/pages/Chat/ChatModel.dart';
import 'package:odc_mobile_project/chat/ui/pages/ChatList/ChatUsersModel.dart';

class ChatState {
  bool isLoading;
  List<ChatModel> chatList = [];
  ChatUsersModel chatUsers ;

  ChatState({
    this.isLoading = false,
    this.chatList = const [],
    required this.chatUsers,
  });

  ChatState copyWith({
    bool? isLoading,
    List<ChatModel>? chatList,
    required ChatUsersModel chatUsers
  }) =>
      ChatState(
        isLoading: isLoading ?? this.isLoading,
        chatList: chatList ?? this.chatList,
        chatUsers: chatUsers,
      );
}