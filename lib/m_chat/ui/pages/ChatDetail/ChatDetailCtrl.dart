import 'package:odc_mobile_project/m_chat/business/interactor/chatInteractor.dart';
import 'package:odc_mobile_project/m_chat/business/model/ChatUsersModel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:odc_mobile_project/m_chat/business/model/ChatDetailModel.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/ChatDetail/ChatDetailState.dart';

part "ChatDetailCtrl.g.dart";

@riverpod
class ChatDetailCtrl extends _$ChatDetailCtrl {
  @override
  ChatDetailState build() {
    return ChatDetailState();
  }
}
