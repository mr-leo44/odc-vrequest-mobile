import 'package:odc_mobile_project/m_chat/business/model/ChatModel.dart';
import 'package:odc_mobile_project/m_chat/business/model/ChatUsersModel.dart';
import 'package:signals/signals_flutter.dart';

class ChatState {
  bool isLoading;
  // Signal<List<ChatModel>> chatList = signal(<ChatModel>[]);
  List<ChatModel> chatList = <ChatModel>[];
  ChatModel? newMessage ;

  ChatState({
    this.isLoading = false,
    // required this.chatList,
    this.chatList = const [] ,
    this.newMessage = null ,
  });

  ChatState copyWith({
    bool? isLoading,
    // Signal<List<ChatModel>>? chatList,
    List<ChatModel>? chatList,
    ChatModel? newMessage ,
  }) =>
      ChatState(
        isLoading: isLoading ?? this.isLoading,
        chatList: chatList ?? this.chatList,
        newMessage: newMessage ?? this.newMessage,
      );
}