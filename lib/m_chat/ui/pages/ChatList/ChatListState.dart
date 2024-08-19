import 'package:odc_mobile_project/m_chat/business/model/ChatUsersModel.dart';
import 'package:odc_mobile_project/m_user/business/model/User.dart';

class ChatListState {
  bool isLoading;
  List<ChatUsersModel> chatsUsers = [];
  User? auth;

  ChatListState({
    this.isLoading = false,
    this.chatsUsers = const [],
    this.auth = null,
  });

  ChatListState copyWith({
    bool? isLoading,
    List<ChatUsersModel>? chatsUsers,
    User? auth,
  }) =>
      ChatListState(
        isLoading: isLoading ?? this.isLoading,
        chatsUsers: chatsUsers ?? this.chatsUsers,
        auth: auth ?? this.auth,
      );
}