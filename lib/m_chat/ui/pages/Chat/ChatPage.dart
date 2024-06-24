import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:odc_mobile_project/m_chat/business/model/ChatModel.dart';
import 'package:odc_mobile_project/m_chat/business/model/ChatUsersModel.dart';
import 'package:odc_mobile_project/m_chat/business/model/creerMessageRequete.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/Chat/Bubble.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/Chat/ChatCtrl.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/ChatDetail/ChatDetailPage.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/ChatList/ChatListPage.dart';
import 'package:odc_mobile_project/navigation/routers.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var ctrl = ref.read(chatCtrlProvider.notifier);
      ctrl.getList(widget.chatUsersModel);
    });
  }

  Future<void> onFieldSubmitted() async {
    if (!newMessage.text.isNotEmpty) return;

    addMessage(newMessage.text);

    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    newMessage.text = '';
  }

  addMessage(String text) {
    setState(() {
      var ctrl = ref.read(chatCtrlProvider.notifier);
      ctrl.addMessage(CreerMessageRequete(
        demande: widget.chatUsersModel.demande,
        user: widget.chatUsersModel.demande.initiateur,
        contenu: text,
      ));
      ctrl.getList(widget.chatUsersModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    // final bool isLargeScreen = width > 800;
    var state = ref.watch(chatCtrlProvider);
    List<ChatModel> chatList = state.chatList.reversed.toList();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: _appBar(context, widget, ref),
      body: Column(
        children: [
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
                )),
          ),
          SafeArea(
            bottom: true,
            child: Container(
              constraints: const BoxConstraints(minHeight: 48),
              width: double.infinity,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color(0xFFE5E5EA),
                  ),
                ),
              ),
              child: Stack(
                children: [
                  Form(
                    key: _newMessageKey,
                    child: TextFormField(
                      focusNode: focusNode,
                      //onChanged: onFieldChanged,
                      controller: newMessage,
                      maxLines: null,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.only(
                          right: 42,
                          left: 16,
                          top: 18,
                        ),
                        hintText: 'Message',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      // validator: (String? value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Le nom est obligatoire';
                      //   }
                      // },
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      icon: SvgPicture.asset(
                        "assets/icons/send.svg",
                        // colorFilter: ColorFilter.mode(
                        //   context.select<ChatController, bool>(
                        //           (value) => value.isTextFieldEnable)
                        //       ? const Color(0xFF007AFF)
                        //       : const Color(0xFFBDBDC2),
                        //   BlendMode.srcIn,
                        // ),
                      ),
                      onPressed: () {
                        onFieldSubmitted();
                      },
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
  bool isOnline = true;
  var state = ref.watch(chatCtrlProvider);

  return AppBar(
    leadingWidth: 100,
    automaticallyImplyLeading: true,
    leading: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () => context.pushNamed(Urls.chatList.name),
          icon: Icon(Icons.arrow_back),
        ),
        // ClipRRect(
        //   borderRadius: BorderRadius.circular(48),
        //   child: Container(
        //     width: 40,
        //     child: Image.asset(widget.chatUsersModel.avatar),
        //   ),
        // ),
        CircleAvatar(
          backgroundColor: Colors.white,
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            child: Image.asset(widget.chatUsersModel.avatar),
          ),
        ),
      ],
    ),
    backgroundColor: Colors.amber[700],
    centerTitle: true,
    title: Column(
      children: [
        Text(
          widget.chatUsersModel.demande.ticket,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        if (isOnline)
          Text(
            "Online",
            style: TextStyle(fontSize: 12),
          ),
      ],
    ),
    actions: [
      _PopupMenuButton(widget: widget),
      // IconButton(
      //   onPressed: () {},
      //   icon: Icon(Icons.videocam_outlined),
      // ),
      // IconButton(
      //   onPressed: () {},
      //   icon: Icon(Icons.call_outlined),
      // ),
    ],
  );
}

// Widget _sendMessage() {
//   return Container(
//     color: Colors.amber,
//     width: double.infinity,
//     child: TextFormField(
//       decoration: InputDecoration(
//         enabledBorder: InputBorder.none,
//         focusedBorder: InputBorder.none,
//         hintText: "Ecriver un message...",
//         hintStyle: TextStyle(
//           fontSize: 15,
//         ),
//         icon: IconButton(
//           onPressed: () {},
//           icon: Icon(Icons.photo_camera_outlined),
//         ),
//         prefixIcon: IconButton(
//           onPressed: () {},
//           icon: Icon(Icons.attach_file),
//         ),
//         suffixIcon: ClipRRect(
//           borderRadius: BorderRadius.circular(48),
//           child: Container(
//             color: Colors.white,
//             child: IconButton(
//               iconSize: 18,
//               onPressed: () {},
//               icon: Icon(Icons.settings_voice_outlined),
//             ),
//           ),
//         ),
//       ),
//     ),
//   );
// }

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
