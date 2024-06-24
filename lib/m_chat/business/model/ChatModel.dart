import 'package:odc_mobile_project/m_chat/ui/pages/Chat/chat_message_type.dart';
import 'package:odc_mobile_project/m_user/business/model/User.dart';

class ChatModel {
    final String avatar;
    final User user;
    final String message;
    final ChatMessageType type;
    final DateTime time;

    ChatModel({
        this.avatar = "assets/images/avatar_1.png",
        required this.user,
        required this.message,
        required this.type,
        required this.time,
    });

    ChatModel copyWith({
        String? avatar,
        User? user,
        String? message,
        ChatMessageType? type,
        DateTime? time,
    }) => 
        ChatModel(
            avatar: avatar ?? this.avatar,
            user: user ?? this.user,
            message: message ?? this.message,
            type: type ?? this.type,
            time: time ?? this.time,
        );

    factory ChatModel.sent({required User user, required String message}) =>
      ChatModel(user: user, message: message, type: ChatMessageType.sent, time: DateTime.now());

    factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        avatar: json["avatar"] ?? "assets/images/avatar_1.png" ,
        user: json["user"] ?? null ,
        message: json["message"] ?? "" ,
        type: json["type"] ?? null ,
        time: json["time"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "avatar": avatar,
        "user": user,
        "message": message,
        "type": type,
        "time": time,
    };
}
