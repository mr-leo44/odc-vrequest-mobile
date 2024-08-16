import 'package:odc_mobile_project/m_chat/business/interactor/chatInteractor.dart';
import 'package:odc_mobile_project/m_user/business/interactor/UserInteractor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/ChatDetail/ChatDetailState.dart';
import 'package:signals/signals_flutter.dart';
import 'package:latlong2/latlong.dart';

part "ChatDetailCtrl.g.dart";

@riverpod
class ChatDetailCtrl extends _$ChatDetailCtrl {
  @override
  ChatDetailState build() {
    getUser();
    return ChatDetailState();
  }

  Future getUser()async{
    var usecase = ref.watch(userInteractorProvider).getUserLocalUseCase;
    var res=await usecase.run();
    state = state.copyWith(auth: res);
  }

  void stateConnection(){
    var interactor = ref.watch(chatInteractorProvider);
    effect((){
      var isconnected = interactor.isConnectedUseCase.run();
      var isdeconnected = interactor.isDeconnectedUseCase.run();
      print(isconnected);
      state = state.copyWith(isconnected: isconnected, isdeconnected: isdeconnected);
    });
  }

  Future getRouteUrl(String startPoint, String endPoint)async {
    var interactor = ref.watch(chatInteractorProvider);
    var points = await interactor.getRouteUrlUseCase.run(startPoint, endPoint);
    state = state.copyWith(drawRoute: points);
  }
}


