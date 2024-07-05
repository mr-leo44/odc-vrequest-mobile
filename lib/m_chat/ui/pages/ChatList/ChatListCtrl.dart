import 'package:odc_mobile_project/m_chat/business/interactor/chatInteractor.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/ChatList/ChatListState.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:odc_mobile_project/m_chat/business/model/ChatUsersModel.dart';

part "ChatListCtrl.g.dart";

@riverpod
class ChatListCtrl extends _$ChatListCtrl {
  @override
  ChatListState build() {
    return ChatListState();
  }

  void getList() async {
    state = state.copyWith(isLoading: true, chatsUsers: List.empty());
    var interactor = ref.watch(chatInteractorProvider);
    var res = await interactor.recupererListMessageGroupeUseCase.run("bjhdfdj");
    state = state.copyWith(isLoading: false, chatsUsers: res);
  }
}