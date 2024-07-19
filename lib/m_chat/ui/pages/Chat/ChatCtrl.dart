import 'dart:async';

import 'package:odc_mobile_project/m_chat/business/interactor/chatInteractor.dart';
import 'package:odc_mobile_project/m_chat/business/model/ChatModel.dart';
import 'package:odc_mobile_project/m_chat/business/model/creerMessageRequete.dart';
import 'package:odc_mobile_project/m_demande/business/model/Demande.dart';
import 'package:odc_mobile_project/m_user/business/interactor/UserInteractor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/Chat/ChatState.dart';
import 'package:odc_mobile_project/m_chat/business/model/ChatUsersModel.dart';
import 'package:signals/signals_flutter.dart';

part "ChatCtrl.g.dart";

@riverpod
class ChatCtrl extends _$ChatCtrl {
  @override
  ChatState build() {
    getUser();
    return ChatState(
      chatList: <ChatModel>[].toSignal(),
    );
  }

  void messageRealTime(ChatUsersModel data){
    var interactor = ref.watch(chatInteractorProvider);
    effect((){
      var message = interactor.messageRealTimeUseCase.run();
      // if((message.user.id > 0 && message.message.isNotEmpty) && (state.auth?.id != message.user.id) ){
      //   var actualList = state.chatList;
      //   actualList.value.add(message);
      //   print("receuved $message");
      //   state = state.copyWith( chatList: actualList);
      // }
       getList(data);
    });
  }

  Future getUser()async{
    var usecase = ref.watch(userInteractorProvider).getUserLocalUseCase;
    var res=await usecase.run();
    state = state.copyWith(auth: res);
  }

  void realTime()async{
    getUser();
    // Timer.periodic(Duration(seconds: 5), (timer) async {
      var interactor = ref.watch(chatInteractorProvider);
      await interactor.realTimeUseCase.run(state.auth);
    // });  
  }

  void getList(ChatUsersModel data) async {
    state = state.copyWith(isLoading: true);
    getUser();
    var interactor = ref.watch(chatInteractorProvider);
    var lists =
        await interactor.recupererListMessageDetailUseCase.run(data, state.auth);
    state = state.copyWith(isLoading: false, chatList: lists.toSignal());
  }

  Future<bool> addMessage(CreerMessageRequete data) async {
    var interactor = ref.watch(chatInteractorProvider);
    var res = await interactor.creerMessageUseCase.run(data);
    return res;
  }

  Future<bool> joinRoom(Demande demande)async{
    getUser();
    var interactor = ref.watch(chatInteractorProvider);
    var joined =
        await interactor.joinRoomUseCase.run(demande, state.auth);
    return joined;
  }
}
