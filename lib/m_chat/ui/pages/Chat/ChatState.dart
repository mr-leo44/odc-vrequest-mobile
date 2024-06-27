import 'package:odc_mobile_project/m_chat/business/model/ChatModel.dart';
import 'package:odc_mobile_project/m_chat/business/model/ChatUsersModel.dart';

class ChatState {
  bool isLoading;
  List<ChatModel> chatList = [];

  ChatState({
    this.isLoading = false,
    this.chatList = const [],
  });

  ChatState copyWith({
    bool? isLoading,
    List<ChatModel>? chatList,
  }) =>
      ChatState(
        isLoading: isLoading ?? this.isLoading,
        chatList: chatList ?? this.chatList,
      );
}