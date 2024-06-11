import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:odc_mobile_project/chat/ui/pages/ChatList/ChatListState.dart';
import 'package:odc_mobile_project/chat/ui/pages/ChatList/ChatUsersModel.dart';

part "ChatListCtrl.g.dart";

@riverpod
class ChatListCtrl extends _$ChatListCtrl {
  @override
  ChatListState build() {
    return ChatListState();
  }

  void getList() async {
    state = state.copyWith(isLoading: true);

    List<ChatUsersModel> chatUsers = [
      ChatUsersModel(
        avatar: 'assets/images/avatar.jpeg',
        ticket: 'Basni76545s',
        lastSender: 'Bap Mutemba',
        lastMessage: 'CamekvhjkbjlnkkjhbvmkhvDodkfnjdgjhcfggbjhnkmljnbhgvcfhj',
        isVideo: false,
        isMessageRead: true,
        time: '20:18',
        unread: 0,
      ),
      ChatUsersModel(
        avatar: 'assets/images/avatar.jpeg',
        ticket: 'Power',
        lastSender: 'Ghost',
        lastMessage: '',
        isVideo: true,
        isMessageRead: false,
        time: 'Jan 12',
        unread: 2,
      ),
      ChatUsersModel(
        avatar: 'assets/images/avatar.jpeg',
        ticket: 'd50Centd97',
        lastSender: '50 cent',
        lastMessage: '',
        isVideo: false,
        isMessageRead: false,
        time: 'Yesterday',
        unread: 1,
      ),
    ];

    state = state.copyWith(isLoading: false, chatsUsers: chatUsers);
  }
}