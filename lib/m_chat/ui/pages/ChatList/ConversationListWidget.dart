import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:odc_mobile_project/m_chat/business/model/ChatUsersModel.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/Chat/ChatCtrl.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/Chat/ChatPage.dart';
import 'package:odc_mobile_project/utils/colors.dart';

class ConversationListWidget extends ConsumerStatefulWidget {
  ChatUsersModel chatUsersModel;

  ConversationListWidget({required this.chatUsersModel});

  @override
  ConsumerState<ConversationListWidget> createState() => _ConversationlistState();
}

class _ConversationlistState extends ConsumerState<ConversationListWidget> {

  @override
  Widget build(BuildContext context) {
    var title = widget.chatUsersModel.demande.ticket ;

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
                    backgroundColor: Colors.white ,
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
                            title,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          _subTitle(widget,this.ref),
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
                      color: Couleurs.primary,
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

Widget _subTitle(widget, WidgetRef ref) {
  var state = ref.watch(chatCtrlProvider);
  ChatUsersModel chatUsersModel = widget.chatUsersModel;
  return Row(
    children: [
      if(chatUsersModel.lastSender.id != 0)
        (chatUsersModel.isMessageRead )
        ? Row(
            children: [
              Icon(
                Icons.done_all,
                color: !chatUsersModel.isMessageRead
                    ? Couleurs.primary
                    : Colors.grey.shade500,
                size: 15,
              ),
              SizedBox(
                width: 4,
              )
            ],
          )
        : Row(
            children: [
              Icon(
                Icons.check,
                color: !chatUsersModel.isMessageRead
                    ? Couleurs.primary
                    : Colors.grey.shade500,
                size: 15,
              ),
              SizedBox(
                width: 4,
              )
            ],
          ),

      Row(
        children: [
          if (chatUsersModel.isPicture)
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
                        ? Couleurs.primary
                        : Colors.grey.shade500,
                    fontWeight: !widget.chatUsersModel.isMessageRead
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),

          if(chatUsersModel.isVideo)
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
                        ? Couleurs.primary
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
      ),
      if(chatUsersModel.lastSender.id != 0 && ((!chatUsersModel.isPicture) && (!chatUsersModel.isVideo)) )
        Expanded(
          child: Text(
            '~ ' +
                chatUsersModel.lastSender.username +
                ' : ' +
                chatUsersModel.lastMessage,
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 13,
                color: !chatUsersModel.isMessageRead
                    ? Couleurs.primary
                    : Colors.grey.shade500,
                fontWeight: !chatUsersModel.isMessageRead
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
