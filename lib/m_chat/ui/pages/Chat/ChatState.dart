import 'package:odc_mobile_project/m_chat/business/model/ChatModel.dart';
import 'package:odc_mobile_project/m_chat/business/model/ChatUsersModel.dart';
import 'package:odc_mobile_project/m_user/business/model/User.dart';
import 'package:signals/signals_flutter.dart';

class ChatState {
  bool isLoading;
  List<ChatModel> chatList = <ChatModel>[];
  // List<ChatModel> chatList = <ChatModel>[];
  ChatModel? newMessage ;
  User? auth;

  ChatState({
    this.isLoading = false,
    // required this.chatList,
    this.chatList = const <ChatModel>[],
    this.newMessage = null ,
    this.auth = null,
  });

  ChatState copyWith({
    bool? isLoading,
    // Signal<List<ChatModel>>? chatList,
    List<ChatModel>? chatList,
    ChatModel? newMessage ,
    User? auth,
  }) =>
      ChatState(
        isLoading: isLoading ?? this.isLoading,
        chatList: chatList ?? this.chatList,
        newMessage: newMessage ?? this.newMessage,
        auth: auth ?? this.auth,
      );
}