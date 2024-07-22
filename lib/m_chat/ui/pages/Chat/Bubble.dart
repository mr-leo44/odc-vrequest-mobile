library flutter_chat_bubble;

import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:odc_mobile_project/m_chat/business/model/ChatModel.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/Chat/AspectRatioVideo.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/Chat/Formatter.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/Chat/chat_message_type.dart';

class Bubble extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final ChatModel chat;

  Bubble({
    super.key,
    this.margin,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignmentOnType,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (chat.type == ChatMessageType.received)
          CircleAvatar(
            backgroundImage: AssetImage(chat.avatar),
          ),
        Container(
          margin: margin ?? EdgeInsets.zero,
          child: PhysicalShape(
            clipper: clipperOnType,
            elevation: 2,
            color: bgColorOnType,
            shadowColor: Colors.grey.shade200,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8,
              ),
              padding: paddingOnType,
              child: Column(
                crossAxisAlignment: crossAlignmentOnType,
                children: [
                  if (chat.type == ChatMessageType.received)
                    Text(
                      chat.user!.username,
                      style: TextStyle(
                          color: Color(0xFF007AFF),
                          fontWeight: FontWeight.bold),
                    ),
                  SizedBox(
                    height: 3,
                  ),
                  if (chat.isPicture)
                    Semantics(
                      label: 'picked_image',
                      child: Image.network(
                        chat.file,
                        errorBuilder: (BuildContext context, Object error,
                            StackTrace? stackTrace) {
                          return const Center(
                              child: Text('This image type is not supported'));
                        },
                      ),
                    ),
                  if (chat.isVideo)
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child:  Image.asset(
                        "assets/icons/play.png",
                        width: 25,
                      ),
                    ),
                  SizedBox(height: 2),
                  Card(
                    shadowColor: Colors.transparent,
                    elevation: 30,
                    color: Colors.transparent,
                    child: Text(
                      chat.message,
                      style: TextStyle(color: textColorOnType),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  if (chat.type == ChatMessageType.received)
                    Text(
                      chat.user.role.isNotEmpty ? chat.user.role.first : '',
                      style: TextStyle(
                        color: Color(0xFF007AFF),
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    Formatter.formatDateTime(chat.time),
                    style: TextStyle(color: textColorOnType, fontSize: 12),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Color get textColorOnType {
    switch (chat.type) {
      case ChatMessageType.sent:
        return Colors.white;
      case ChatMessageType.received:
        return const Color(0xFF0F0F0F);
      case null:
        return Colors.black;
    }
  }

  Color get bgColorOnType {
    switch (chat.type) {
      case ChatMessageType.received:
        return const Color(0xFFE7E7ED);
      case ChatMessageType.sent:
        return const Color(0xFF007AFF);
      case null:
        return Colors.black;
    }
  }

  CustomClipper<Path> get clipperOnType {
    switch (chat.type) {
      case ChatMessageType.sent:
        return ChatBubbleClipper1(type: BubbleType.sendBubble);
      case ChatMessageType.received:
        return ChatBubbleClipper1(type: BubbleType.receiverBubble);
      case null:
        return ChatBubbleClipper1(type: BubbleType.receiverBubble);
    }
  }

  CrossAxisAlignment get crossAlignmentOnType {
    switch (chat.type) {
      case ChatMessageType.sent:
        return CrossAxisAlignment.end;
      case ChatMessageType.received:
        return CrossAxisAlignment.start;
      case null:
        return CrossAxisAlignment.start;
    }
  }

  MainAxisAlignment get alignmentOnType {
    switch (chat.type) {
      case ChatMessageType.received:
        return MainAxisAlignment.start;
      case ChatMessageType.sent:
        return MainAxisAlignment.end;
      case null:
        return MainAxisAlignment.start;
    }
  }

  EdgeInsets get paddingOnType {
    switch (chat.type) {
      case ChatMessageType.sent:
        return const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 24);
      case ChatMessageType.received:
        return const EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: 24,
          right: 10,
        );
      case null:
        return const EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: 24,
          right: 10,
        );
    }
  }
}
