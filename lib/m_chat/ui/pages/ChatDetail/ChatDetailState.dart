

import 'package:odc_mobile_project/m_chat/business/model/ChatDetailModel.dart';
import 'package:odc_mobile_project/m_chat/business/model/Passager.dart';

class ChatDetailState {
  bool isLoading;
  Passager? passager;

  ChatDetailState({
    this.isLoading = false,
    this.passager,
  });

  ChatDetailState copyWith({
    bool? isLoading,
    Passager? passager
  }) =>
      ChatDetailState(
        isLoading: isLoading ?? this.isLoading,
        passager: passager ?? this.passager,
      );
}