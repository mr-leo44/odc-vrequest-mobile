import 'package:odc_mobile_project/m_chat/ui/pages/ChatList/ChatUsersModel.dart';

class ChatListState {
  bool isLoading;
  List<ChatUsersModel> chatsUsers = [];

  ChatListState({
    this.isLoading = false,
    this.chatsUsers = const [],
  });

  ChatListState copyWith({
    bool? isLoading,
    List<ChatUsersModel>? chatsUsers
  }) =>
      ChatListState(
        isLoading: isLoading ?? this.isLoading,
        chatsUsers: chatsUsers ?? this.chatsUsers,
      );
}