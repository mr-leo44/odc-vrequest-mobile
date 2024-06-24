

import 'package:odc_mobile_project/m_chat/business/model/ChatDetailModel.dart';

class ChatDetailState {
  bool isLoading;

  ChatDetailState({
    this.isLoading = false,
  });

  ChatDetailState copyWith({
    bool? isLoading,
  }) =>
      ChatDetailState(
        isLoading: isLoading ?? this.isLoading,
      );
}