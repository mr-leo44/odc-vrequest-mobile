import 'package:odc_mobile_project/m_chat/business/interactor/chatInteractor.dart';
import 'package:odc_mobile_project/m_chat/business/model/ChatUsersModel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:odc_mobile_project/m_chat/business/model/ChatDetailModel.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/ChatDetail/ChatDetailState.dart';
import 'package:odc_mobile_project/m_chat/business/model/Passager.dart';

part "ChatDetailCtrl.g.dart";

@riverpod
class ChatDetailCtrl extends _$ChatDetailCtrl {
  @override
  ChatDetailState build() {
    return ChatDetailState();
  }

  void getPassagers(ChatUsersModel chatUsersModel) async {
    state = state.copyWith(isLoading: true,);
    var interactor = ref.watch(chatInteractorProvider);
    var res = await interactor.recupererPassagersUseCase.run(chatUsersModel);
    state = state.copyWith(isLoading: false, passager: res);
  }
}
