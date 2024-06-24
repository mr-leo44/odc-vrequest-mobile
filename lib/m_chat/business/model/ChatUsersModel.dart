import 'package:odc_mobile_project/m_chat/business/model/DemandeChat.dart';
import 'package:odc_mobile_project/m_user/business/model/User.dart';

class ChatUsersModel {
    String avatar;
    DemandeChat demande;
    User lastSender;
    String lastMessage;
    bool isVideo;
    bool isMessageRead;
    String time;
    int unread;

    ChatUsersModel({
        this.avatar = "assets/images/car3.webp",
        required this.demande,
        required this.lastSender,
        required this.lastMessage,
        required this.isVideo,
        required this.isMessageRead,
        required this.time,
        required this.unread,
    });

    ChatUsersModel copyWith({
        String? avatar,
        DemandeChat? demande,
        User? lastSender,
        String? lastMessage,
        bool? isVideo,
        bool? isMessageRead,
        String? time,
        int? unread,
    }) => 
        ChatUsersModel(
            avatar: avatar ?? this.avatar,
            demande: demande ?? this.demande ,
            lastSender: lastSender ?? this.lastSender,
            lastMessage: lastMessage ?? this.lastMessage,
            isVideo: isVideo ?? this.isVideo,
            isMessageRead: isMessageRead ?? this.isMessageRead,
            time: time ?? this.time,
            unread: unread ?? this.unread,
        );

    factory ChatUsersModel.fromJson(Map<String, dynamic> json) => ChatUsersModel(
        avatar: json["avatar"] ?? "assets/images/car3.webp" ,
        demande: json["demande"] ?? null ,
        lastSender: json["lastSender"] ?? null ,
        lastMessage: json["lastMessage"] ?? "" ,
        isVideo: json["isVideo"] ?? false ,
        isMessageRead: json["isMessageRead"] ?? false ,
        time: json["time"] ?? "" ,
        unread: json["unread"] ?? -1,
    );

    Map<String, dynamic> toJson() => {
        "avatar": avatar,
        "demande": demande,
        "lastSender": lastSender,
        "lastMessage": lastMessage,
        "isVideo": isVideo,
        "isMessageRead": isMessageRead,
        "time": time,
        "unread": unread,
    };
}

