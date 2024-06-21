

import 'package:odc_mobile_project/m_chat/ui/pages/ChatDetail/ChatDetailModel.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/ChatDetail/Passager.dart';

class ChatDetailState {
  bool isLoading;
  ChatDetailModel chatDetail ;
  Passager? passager;

  ChatDetailState({
    this.isLoading = false,
    required this.chatDetail,
    this.passager,
  });

  ChatDetailState copyWith({
    bool? isLoading,
    required ChatDetailModel chatDetail,
    Passager? passager
  }) =>
      ChatDetailState(
        isLoading: isLoading ?? this.isLoading,
        chatDetail: chatDetail,
        passager: passager ?? this.passager,
      );
}