import 'package:odc_mobile_project/m_chat/ui/pages/Chat/chat_message_type.dart';
import 'package:odc_mobile_project/m_demande/business/model/Demande.dart';
import 'package:odc_mobile_project/m_user/business/model/User.dart';

class ChatModel {
  Demande demande;
  String avatar;
  User user;
  String message;
  ChatMessageType? type;
  DateTime time;
  String file;
  bool isPicture;
  bool isVideo;

  ChatModel({
    required this.demande,
    this.avatar = "assets/images/avatar_1.png",
    required this.user,
    required this.message,
    required this.type,
    required this.time,
    this.file = "",
    this.isPicture = false,
    this.isVideo = false,
  });

  ChatModel copyWith({
    Demande? demande,
    String? avatar,
    User? user,
    String? message,
    ChatMessageType? type,
    DateTime? time,
    String? file,
    bool? isPicture,
    bool? isVideo,
  }) =>
      ChatModel(
        demande: demande ?? this.demande,
        avatar: avatar ?? this.avatar,
        user: user ?? this.user,
        message: message ?? this.message,
        type: type ?? this.type,
        time: time ?? this.time,
        file: file ?? this.file,
        isPicture: isPicture ?? this.isPicture,
        isVideo: isVideo ?? this.isVideo,
      );

  factory ChatModel.sent(
          {required User user, required String message, required demande}) =>
      ChatModel(
        demande: demande,
        user: user,
        message: message,
        type: ChatMessageType.sent,
        time: DateTime.now(),
      );

  factory ChatModel.fromJson(Map json) => ChatModel(
        demande: json["demande"] ??
            Demande(
                dateDemande: DateTime.now(),
                dateDeplacement: DateTime.now(),
                initiateur: User(
                  id: 0,
                  emailVerifiedAt: DateTime.now(),
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                ),
                manager: null,
                chefCharroi: null,
                chauffeur: User(
                  id: 0,
                  emailVerifiedAt: DateTime.now(),
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                ),
                createAt: DateTime.now()),
        avatar: json["avatar"] ?? "assets/images/avatar_1.png",
        user: json["user"] ??
            User(
                id: 0,
                emailVerifiedAt: DateTime.now(),
                createdAt: DateTime.now(),
                updatedAt: DateTime.now()),
        message: json["contenu"] ?? "",
        type: json["type"] ?? null,
        time: json["time"] ?? DateTime.now(),
        file: json["file"] ?? "",
        isPicture: json["isPicture"] ?? false,
        isVideo: json["isVideo"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "demande": demande,
        "avatar": avatar,
        "user": user,
        "contenu": message,
        "type": type,
        "time": time,
        "file": file,
        "isPicture": isPicture,
        "isVideo": isVideo,
      };
}
