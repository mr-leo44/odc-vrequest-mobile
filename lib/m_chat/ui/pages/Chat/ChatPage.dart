import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_touch_ripple/components/behavior.dart';
import 'package:flutter_touch_ripple/flutter_touch_ripple.dart';
import 'package:go_router/go_router.dart';
import 'package:odc_mobile_project/m_chat/business/model/ChatModel.dart';
import 'package:odc_mobile_project/m_chat/business/model/ChatUsersModel.dart';
import 'package:odc_mobile_project/m_chat/business/model/creerMessageRequete.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/Chat/Bubble.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/Chat/ChatCtrl.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/Chat/chat_message_type.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/ChatDetail/ChatDetailPage.dart';
import 'package:odc_mobile_project/m_user/business/model/User.dart';
import 'package:odc_mobile_project/navigation/routers.dart';
import 'package:signals/signals_flutter.dart';

class ChatPage extends ConsumerStatefulWidget {
  ChatUsersModel chatUsersModel;

  ChatPage({required this.chatUsersModel});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  late final ScrollController scrollController = ScrollController();
  late final TextEditingController newMessage = TextEditingController();
  late final FocusNode focusNode = FocusNode();
  final _newMessageKey = GlobalKey<FormState>();

  void initState() {
    super.initState();
    newMessage.addListener(() {
      setState(() {}); // setState every time text changes
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var ctrl = ref.read(chatCtrlProvider.notifier);
      ctrl.getList(widget.chatUsersModel);
      ctrl.realTime();
      ctrl.messageRealTime();
    });
  }

  @override
  void dispose() {
    newMessage.dispose();
    super.dispose();
  }

  Future<void> onFieldSubmitted(BuildContext context) async {
    if (!newMessage.text.isNotEmpty) return;

    addMessage(newMessage.text, context);

    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    newMessage.text = '';
  }

  addMessage(
    String text,
    BuildContext context,
  ) async {
    var ctrl = ref.read(chatCtrlProvider.notifier);
    var resp = await ctrl.addMessage(CreerMessageRequete(
      demande: widget.chatUsersModel.demande,
      user: User(
        id: 1,
        emailVerifiedAt: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      contenu: text,
    ));
    if (resp) {
      // setState(() {
      // ctrl.getList(widget.chatUsersModel);
      // });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Le message n\'a pas ete ajoute, veuillez reessayer svp'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    // final bool isLargeScreen = width > 800;
    var state = ref.watch(chatCtrlProvider);
    List<ChatModel> chatList = state.chatList.reversed.toList();
    if (state.newMessage != null) {
      chatList.insert(0,
        ChatModel.fromJson({
          "user": state.newMessage?.user,
          "contenu": state.newMessage?.message,
          "type":
              (state.newMessage?.user.id == 1) ? ChatMessageType.sent : ChatMessageType.received,
          "time": state.newMessage?.time,
        }),
      );
    }
    // chatList.reversed.toList();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: _appBar(context, widget, ref),
      body: Column(
        children: [
          // Center(
          //   child: Text(state.newMessage?.message ?? ""),
          // ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Align(
                alignment: Alignment.topCenter,
                child: ListView.separated(
                  shrinkWrap: true,
                  reverse: true,
                  padding: const EdgeInsets.only(top: 12, bottom: 20) +
                      const EdgeInsets.symmetric(horizontal: 12),
                  separatorBuilder: (_, __) => const SizedBox(
                    height: 12,
                  ),
                  controller: scrollController,
                  itemBuilder: (context, index) {
                    return Bubble(chat: chatList[index]);
                  },
                  itemCount: chatList.length,
                ),
              ),
            ),
          ),
          SafeArea(
            bottom: true,
            child: Container(
              color: Colors.transparent,
              constraints: const BoxConstraints(minHeight: 48),
              margin: EdgeInsets.only(bottom: 5, top: 5),
              padding: EdgeInsets.all(5),
              width: double.infinity,
              child: Stack(
                children: [
                  Form(
                    key: _newMessageKey,
                    child: TextFormField(
                      focusNode: focusNode,
                      controller: newMessage,
                      maxLines: null,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFE7E7ED),
                        border: InputBorder.none,
                        hintText: 'Message',
                        contentPadding: EdgeInsets.all(15),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.grey.shade100),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.grey.shade100),
                        ),
                        suffixIcon: IconButton(
                          icon: SvgPicture.asset(
                            "assets/icons/send.svg",
                            colorFilter: ColorFilter.mode(
                              (newMessage.text.isNotEmpty)
                                  ? const Color(0xFF007AFF)
                                  : const Color(0xFFBDBDC2),
                              BlendMode.srcIn,
                            ),
                          ),
                          onPressed: () {
                            onFieldSubmitted(context);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

AppBar _appBar(BuildContext context, widget, WidgetRef ref) {
  var state = ref.watch(chatCtrlProvider);

  return AppBar(
    leadingWidth: 80,
    automaticallyImplyLeading: true,
    leading: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () => context.pushNamed(Urls.chatList.name),
          icon: Icon(Icons.arrow_back),
        ),
        Container(
          width: 30,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              child: Image.asset(widget.chatUsersModel.avatar),
            ),
          ),
        ),
      ],
    ),
    backgroundColor: Colors.amber[700],
    title: TouchRipple(
      onTap: () {
        HapticFeedback.selectionClick();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatDetailPage(
              chatUsersModel: widget.chatUsersModel,
            ),
          ),
        );
      },
      rippleColor: Colors.white.withAlpha(65),
      tapBehavior: TouchRippleBehavior(
        fadeInDuration: Duration(milliseconds: 250),
        eventCallBackableMinPercent: 1,
      ),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.chatUsersModel.demande.ticket,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.chatUsersModel.demande.initiateur.name +
                        ", " +
                        widget.chatUsersModel.demande.chauffeur.name,
                    style: TextStyle(fontSize: 12),
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    actions: [
      _PopupMenuButton(widget: widget),
    ],
  );
}

class _PopupMenuButton extends StatelessWidget {
  var widget;
  _PopupMenuButton({this.widget});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(onSelected: (Widget value) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => value),
      );
    }, itemBuilder: (BuildContext bc) {
      return [
        PopupMenuItem(
          child: Row(
            children: [
              Icon(Icons.info),
              SizedBox(
                width: 4,
              ),
              Text("Info"),
            ],
          ),
          //value: CollapsingAppbarPage() ,
          value: ChatDetailPage(
            chatUsersModel: widget.chatUsersModel,
          ),
        ),
      ];
    });
  }
}
