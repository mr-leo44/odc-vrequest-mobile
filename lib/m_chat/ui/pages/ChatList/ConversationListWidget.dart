import 'package:flutter/material.dart';

class ConversationList extends StatefulWidget {
  String avatar;
  String ticket;
  String lastSender;
  String lastMessage;
  bool isVideo;
  bool isMessageRead;
  String time;
  int unread;

  ConversationList({
    required this.avatar,
    required this.ticket,
    required this.lastSender,
    required this.lastMessage,
    required this.isVideo,
    required this.isMessageRead,
    required this.time,
    required this.unread,
  });
  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
                      child: Image.asset(widget.avatar),
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
                            widget.ticket,
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
                  widget.time,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: !widget.isMessageRead
                          ? FontWeight.bold
                          : FontWeight.normal),
                ),
                if (!widget.isMessageRead)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      color: Colors.amber,
                      child: Text(
                        widget.unread.toString(),
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: !widget.isMessageRead
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
      if (widget.lastSender != "Bap Mutemba")
        if (widget.isMessageRead)
          Row(
            children: [
              Icon(
                Icons.done_all,
                color: !widget.isMessageRead
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
                color: !widget.isMessageRead
                    ? Colors.amber.shade700
                    : Colors.grey.shade500,
                size: 15,
              ),
              SizedBox(
                width: 4,
              )
            ],
          ),
      if (widget.lastMessage.isEmpty)
        Row(
          children: [
            if (!widget.isVideo)
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
                      color: !widget.isMessageRead
                          ? Colors.amber.shade700
                          : Colors.grey.shade500,
                      fontWeight: !widget.isMessageRead
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
                      color: !widget.isMessageRead
                          ? Colors.amber.shade700
                          : Colors.grey.shade500,
                      fontWeight: !widget.isMessageRead
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
            '~ ' + widget.lastSender + ' : ' + widget.lastMessage,
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 13,
                color: !widget.isMessageRead
                    ? Colors.amber.shade700
                    : Colors.grey.shade500,
                fontWeight: !widget.isMessageRead
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
