import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:odc_mobile_project/m_chat/business/interactor/chatInteractor.dart';
import 'package:odc_mobile_project/m_chat/business/model/ChatModel.dart';
import 'package:odc_mobile_project/m_demande/business/model/Demande.dart';
import 'package:odc_mobile_project/m_user/business/interactor/UserInteractor.dart';
import 'package:odc_mobile_project/shared/business/interactor/shared/SharedInteractor.dart';
import 'package:odc_mobile_project/shared/business/model/Notification.dart';
import 'package:odc_mobile_project/shared/ui/pages/shared/SharedState.dart';
import 'package:odc_mobile_project/shared/ui/pages/notification/NotificationController.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:odc_mobile_project/m_chat/business/model/ChatUsersModel.dart';
import 'package:signals/signals_flutter.dart';

part "SharedCtrl.g.dart";

@Riverpod(keepAlive: true)
class SharedCtrl extends _$SharedCtrl {
  @override
  SharedState build() {
    getUser();
    return SharedState(
      newMessages: Signal(<Map<String, List<ChatModel>>>[]),
    );
  }

  void init() async {
    state = state.copyWith(
        isLoading: true,
        newMessages: <Map<String, List<ChatModel>>>[].toSignal());

    List<Map<String, List<ChatModel>>> listInitMessages =
        <Map<String, List<ChatModel>>>[];

    var listDemandes = await getListDemandes();

    for (var i = 0; i < listDemandes.length; i++) {
      joinRoom(listDemandes[i].demande);
      listInitMessages
          .add({listDemandes[i].demande.id.toString(): <ChatModel>[]});
      // print(listDemandes[i].demande.id.toString() +
      //     ":" +
      //     <ChatModel>[].toString());
    }

    state = state.copyWith(
        isLoading: true, newMessages: listInitMessages.toSignal());
  }

  Future<void> messageRealTime() async {
    var interactor = ref.watch(chatInteractorProvider);
    var nm = state.newMessages.value;
    final completer = Completer<void>();
    getUser();
    effect(() {
      var message = interactor.messageRealTimeUseCase.run();

      for (var i = 0; i < nm.length; i++) {
        var listChat = nm[i][message.demande.id.toString()];
        nm[i].forEach((key, value) {
          if (key == message.demande.id.toString()) {
            if (listChat != null) {
              listChat.add(message);
              nm[i][key] = listChat;
            } else {
              nm[i][key] = [message];
            }
          }
        });
      }

      if ((message.user.id != state.auth!.id)) {
        NotificationController.createNewNotification(NotificationPush(
            title: message.user.username,
            body: message.message.isNotEmpty ? message.message : "Piece jointe",
            bigPicture: message.file.isNotEmpty ? message.file : "",
            payload: {
              "payloadId": message.demande.ticket.toString()
            },
            notificationActionButtons: [
              // NotificationActionButton(key: 'REDIRECT', label: 'Ouvrir'),
              NotificationActionButton(
                  key: 'REPLY',
                  label: 'Repondre',
                  requireInputText: true,
                  actionType: ActionType.SilentAction),
              NotificationActionButton(
                  key: 'DISMISS',
                  label: 'Dismiss',
                  actionType: ActionType.DismissAction,
                  isDangerousOption: true)
            ]));
      }
      state = state.copyWith(newMessages: nm.toSignal());
      print("SharedState: ${state.newMessages.value}");
    });

    await completer.future;
  }

  Future<String> getToken() async {
    var usecase = ref.watch(userInteractorProvider).getTokenUseCase;
    var res = await usecase.run();
    return Future.value(res);
  }

  Future<List<ChatUsersModel>> getListDemandes() async {
    state = state.copyWith(
      isLoading: true,
    );
    var token = await getToken();
    var interactor = ref.watch(chatInteractorProvider);
    var res = await interactor.recupererListMessageGroupeUseCase.run(token);
    state = state.copyWith(
      isLoading: false,
    );
    return res;
  }

  Future getUser() async {
    var usecase = ref.watch(userInteractorProvider).getUserLocalUseCase;
    var res = await usecase.run();
    state = state.copyWith(auth: res);
  }

  void realTime() async {
    var interactor = ref.watch(chatInteractorProvider);
    await interactor.realTimeUseCase.run(state.auth);
  }

  Future<bool> joinRoom(Demande demande) async {
    var interactor = ref.watch(chatInteractorProvider);
    var joined = await interactor.joinRoomUseCase.run(demande, state.auth);
    return joined;
  }

  Future<void> getLocation(Demande demande) async {
    var interactor = ref.watch(sharedInteractorProvider);
    await interactor.getLocationUseCase.run(demande, state.auth);
    print("getLocation ${state.location}");
  }

  Future<void> locationRealTime()async{
    var interactor = ref.watch(sharedInteractorProvider);
    effect(() async {
      state = state.copyWith(isLoading: true);
      Map<String, dynamic> location = await interactor.locationRealTimeUseCase.run();
      if(location.isNotEmpty){
        state = state.copyWith(location: location, isLoading: false);
      }
    });
  }

  Future<void> listenLocation(Demande demande) async {
    state = state.copyWith(isLoading: true);

    Location().onLocationChanged.handleError((dynamic err) {
      if (err is PlatformException) {
        state = state.copyWith(location: null, isLoading: false);
      }
    }).listen((currentLocation) async {
      var interactor = ref.watch(sharedInteractorProvider);
      Map<String, dynamic> _location = {
        "longitude" : await currentLocation.longitude.toString(),
        "latitude" : await currentLocation.latitude.toString(),
      };
      await interactor.sendLocationUseCase.run(_location, demande);
    });
  }

  Future<void> requestLocationPermission() async {
    PermissionStatus? permissionRequestedResult;

    if (checkPermissions != PermissionStatus.granted) {
      permissionRequestedResult = await Location().requestPermission();
    }
  }

  Future<PermissionStatus?> checkPermissions() async {
    return await Location().hasPermission();
  }
}
