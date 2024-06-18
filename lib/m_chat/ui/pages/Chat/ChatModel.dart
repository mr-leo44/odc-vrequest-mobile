import 'package:odc_mobile_project/chat/ui/pages/Chat/chat_message_type.dart';

class ChatModel {
    final String message;
    final ChatMessageType type;
    final DateTime time;

    ChatModel({
        required this.message,
        required this.type,
        required this.time,
    });

    ChatModel copyWith({
        String? message,
        ChatMessageType? type,
        DateTime? time,
    }) => 
        ChatModel(
            message: message ?? this.message,
            type: type ?? this.type,
            time: time ?? this.time,
        );

    factory ChatModel.sent({required message}) =>
      ChatModel(message: message, type: ChatMessageType.sent, time: DateTime.now());
}
