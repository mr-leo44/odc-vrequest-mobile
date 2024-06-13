class ChatUsersModel {
  String avatar;
  String ticket;
  String lastSender;
  String lastMessage;
  bool isVideo;
  bool isMessageRead;
  String time;
  int unread;

  ChatUsersModel({
    this.avatar = "assets/images/avatar.jpeg" ,
    required this.ticket,
    required this.lastSender,
    required this.lastMessage,
    required this.isVideo,
    required this.isMessageRead,
    required this.time,
    required this.unread,
  });
}
