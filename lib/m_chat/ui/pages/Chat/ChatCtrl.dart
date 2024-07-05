import 'dart:async';
import 'dart:ffi';

import 'package:odc_mobile_project/m_chat/business/interactor/chatInteractor.dart';
import 'package:odc_mobile_project/m_chat/business/model/ChatModel.dart';
import 'package:odc_mobile_project/m_chat/business/model/creerMessageRequete.dart';
import 'package:odc_mobile_project/m_user/business/model/User.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/Chat/ChatState.dart';
import 'package:odc_mobile_project/m_chat/business/model/ChatUsersModel.dart';
import 'package:signals/signals_flutter.dart';

part "ChatCtrl.g.dart";

@riverpod
class ChatCtrl extends _$ChatCtrl {
  // Signal<List<ChatModel>> lists = signal(<ChatModel>[]);
  // var message = signal("");

  @override
  ChatState build() {
    // return ChatState(
    //   chatList: signal(<ChatModel>[]),
    // );
    return ChatState( );
  }

  void messageRealTime(){
    var interactor = ref.watch(chatInteractorProvider);
    effect((){
      var message = interactor.messageRealTimeUseCase.run();
      if(message.user.id > 0 && message.message.isNotEmpty ){
        state = state.copyWith( newMessage: message);
      }
    });
  }

  void realTime()async{
    // Timer.periodic(Duration(seconds: 5), (timer) async {
      var interactor = ref.watch(chatInteractorProvider);
      await interactor.realTimeUseCase.run();
    // });  
  }

  void getList(ChatUsersModel $data) async {
    state = state.copyWith(isLoading: true);
    // effect(() async {
    //   Timer.periodic(Duration(seconds: 5), (timer) async {
    //     print("Periodic run");
    //     var interactor = ref.watch(chatInteractorProvider);
    //     lists.value =
    //         await interactor.recupererListMessageDetailUseCase.run($data);
    //   });
    // });
    var interactor = ref.watch(chatInteractorProvider);
    var lists =
        await interactor.recupererListMessageDetailUseCase.run($data);
    state = state.copyWith(isLoading: false, chatList: lists);
  }

  Future<bool> addMessage(CreerMessageRequete data) async {
    var interactor = ref.watch(chatInteractorProvider);
    var res = await interactor.creerMessageUseCase.run(data);
    return res;
  }
}
