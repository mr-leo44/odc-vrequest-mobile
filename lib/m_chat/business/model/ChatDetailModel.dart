import 'package:odc_mobile_project/m_chat/business/model/ChatUsersModel.dart';

class ChatDetailModel {
    ChatUsersModel chatUsersModel;

    ChatDetailModel({
        required this.chatUsersModel,
    });

    ChatDetailModel copyWith({
      ChatUsersModel? chatUsersModel,
    }) => 
        ChatDetailModel(
            chatUsersModel: chatUsersModel ?? this.chatUsersModel,
        );
}
