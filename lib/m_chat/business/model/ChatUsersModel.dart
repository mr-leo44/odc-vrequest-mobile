import 'package:odc_mobile_project/m_demande/business/model/Demande.dart';
import 'package:odc_mobile_project/m_user/business/model/User.dart';

class ChatUsersModel {
    String avatar;
    Demande demande;
    User lastSender;
    String lastMessage;
    bool isVideo;
    bool isPicture;
    bool isMessageRead;
    String time;
    int unread;

    ChatUsersModel({
        this.avatar = "assets/images/car3.webp",
        required this.demande,
        required this.lastSender,
        required this.lastMessage,
        this.isVideo = false,
        this.isPicture = false,
        this.isMessageRead = false,
        required this.time,
        this.unread = 0,
    });

    ChatUsersModel copyWith({
        String? avatar,
        Demande? demande,
        User? lastSender,
        String? lastMessage,
        bool? isVideo,
        bool? isPicture,
        bool? isMessageRead,
        String? time,
        int? unread,
    }) => 
        ChatUsersModel(
            avatar: avatar ?? this.avatar,
            demande: demande ?? this.demande ,
            lastSender: lastSender ?? this.lastSender,
            lastMessage: lastMessage ?? this.lastMessage,
            isPicture: isPicture ?? this.isPicture,
            isVideo: isVideo ?? this.isVideo,
            isMessageRead: isMessageRead ?? this.isMessageRead,
            time: time ?? this.time,
            unread: unread ?? this.unread,
        );

    factory ChatUsersModel.fromJson(Map json) => ChatUsersModel(
        avatar: json["avatar"] ?? "assets/images/car3.webp" ,
        demande: json["demande"] ?? null ,
        lastSender: json["lastSender"] ?? null ,
        lastMessage: json["lastMessage"] ?? "" ,
        isPicture: json["isPicture"] ?? false,
        isVideo: json["isVideo"] ?? false ,
        isMessageRead: json["isMessageRead"] ?? false ,
        time: json["time"] ?? "" ,
        unread: json["unread"] ?? 0,
    );

    Map<String, dynamic> toJson() => {
        "avatar": avatar,
        "demande": demande,
        "lastSender": lastSender,
        "lastMessage": lastMessage,
        "isPicture": isPicture,
        "isVideo": isVideo,
        "isMessageRead": isMessageRead,
        "time": time,
        "unread": unread,
    };
}

