import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:odc_mobile_project/m_chat/business/model/ChatUsersModel.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/Chat/ChatPage.dart';
import 'package:odc_mobile_project/navigation/routers.dart';

class ConversationListWidget extends StatefulWidget {
  ChatUsersModel chatUsersModel;

  ConversationListWidget({required this.chatUsersModel});
  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationListWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatPage(
            chatUsersModel: widget.chatUsersModel,
          ),
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      child: Image.asset(widget.chatUsersModel.avatar),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.chatUsersModel.ticket,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          _subTitle(widget),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  widget.chatUsersModel.time,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: !widget.chatUsersModel.isMessageRead
                          ? FontWeight.bold
                          : FontWeight.normal),
                ),
                if (!widget.chatUsersModel.isMessageRead)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      color: Colors.amber,
                      child: Text(
                        widget.chatUsersModel.unread.toString(),
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: !widget.chatUsersModel.isMessageRead
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _subTitle(widget) {
  return Row(
    children: [
      if (widget.chatUsersModel.lastSender != "Bap Mutemba")
        if (widget.chatUsersModel.isMessageRead)
          Row(
            children: [
              Icon(
                Icons.done_all,
                color: !widget.chatUsersModel.isMessageRead
                    ? Colors.amber.shade700
                    : Colors.grey.shade500,
                size: 15,
              ),
              SizedBox(
                width: 4,
              )
            ],
          )
        else
          Row(
            children: [
              Icon(
                Icons.check,
                color: !widget.chatUsersModel.isMessageRead
                    ? Colors.amber.shade700
                    : Colors.grey.shade500,
                size: 15,
              ),
              SizedBox(
                width: 4,
              )
            ],
          ),
      if (widget.chatUsersModel.lastMessage.isEmpty)
        Row(
          children: [
            if (!widget.chatUsersModel.isVideo)
              Row(
                children: [
                  Icon(
                    Icons.camera_alt,
                    color: Colors.grey.shade500,
                    size: 15,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    "Photo",
                    softWrap: false,
                    style: TextStyle(
                      color: !widget.chatUsersModel.isMessageRead
                          ? Colors.amber.shade700
                          : Colors.grey.shade500,
                      fontWeight: !widget.chatUsersModel.isMessageRead
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              )
            else
              Row(
                children: [
                  Icon(
                    Icons.videocam,
                    color: Colors.grey.shade500,
                    size: 15,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    "Video",
                    softWrap: false,
                    style: TextStyle(
                      color: !widget.chatUsersModel.isMessageRead
                          ? Colors.amber.shade700
                          : Colors.grey.shade500,
                      fontWeight: !widget.chatUsersModel.isMessageRead
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
          ],
        )
      else
        Expanded(
          child: Text(
            '~ ' +
                widget.chatUsersModel.lastSender +
                ' : ' +
                widget.chatUsersModel.lastMessage,
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 13,
                color: !widget.chatUsersModel.isMessageRead
                    ? Colors.amber.shade700
                    : Colors.grey.shade500,
                fontWeight: !widget.chatUsersModel.isMessageRead
                    ? FontWeight.bold
                    : FontWeight.normal),
          ),
        ),
      SizedBox(
        width: 4,
      ),
    ],
  );
}
