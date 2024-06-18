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
        required this.avatar,
        required this.ticket,
        required this.lastSender,
        required this.lastMessage,
        required this.isVideo,
        required this.isMessageRead,
        required this.time,
        required this.unread,
    });

    ChatUsersModel copyWith({
        String? avatar,
        String? ticket,
        String? lastSender,
        String? lastMessage,
        bool? isVideo,
        bool? isMessageRead,
        String? time,
        int? unread,
    }) => 
        ChatUsersModel(
            avatar: avatar ?? "assets/images/avatar.jpeg",
            ticket: ticket ?? this.ticket,
            lastSender: lastSender ?? this.lastSender,
            lastMessage: lastMessage ?? this.lastMessage,
            isVideo: isVideo ?? this.isVideo,
            isMessageRead: isMessageRead ?? this.isMessageRead,
            time: time ?? this.time,
            unread: unread ?? this.unread,
        );
}

