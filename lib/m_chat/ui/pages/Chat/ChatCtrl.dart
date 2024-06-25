import 'package:odc_mobile_project/m_chat/business/interactor/chatInteractor.dart';
import 'package:odc_mobile_project/m_chat/business/model/creerMessageRequete.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/Chat/ChatState.dart';
import 'package:odc_mobile_project/m_chat/business/model/ChatUsersModel.dart';

part "ChatCtrl.g.dart";

@riverpod
class ChatCtrl extends _$ChatCtrl {
  
  @override
  ChatState build() {
    return ChatState();
  }

  void getList(ChatUsersModel $data) async {
    state = state.copyWith(isLoading: true,);
    var interactor = ref.watch(chatInteractorProvider);
    var res = await interactor.recupererListMessageDetailUseCase.run($data);
    state = state.copyWith(isLoading: false, chatList: res);
  }

  Future<bool> addMessage(CreerMessageRequete data)async{
    var interactor = ref.watch(chatInteractorProvider);
    var res = await interactor.creerMessageUseCase.run(data);
    return res;
  }
}
