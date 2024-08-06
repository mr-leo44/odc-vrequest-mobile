

import 'package:odc_mobile_project/m_chat/business/model/ChatDetailModel.dart';
import 'package:odc_mobile_project/m_user/business/model/User.dart';

class ChatDetailState {
  bool isLoading;
  int isconnected;
  int isdeconnected;
  User? auth;

  ChatDetailState({
    this.isLoading = false,
    this.isconnected = 0,
    this.isdeconnected = 0,
    this.auth = null,
  });

  ChatDetailState copyWith({
    bool? isLoading,
    int? isconnected,
    int? isdeconnected,
    User? auth,
  }) =>
      ChatDetailState(
        isLoading: isLoading ?? this.isLoading,
        isconnected: isconnected ?? this.isconnected,
        isdeconnected: isdeconnected ?? this.isdeconnected,
        auth: auth ?? this.auth,
      );
}