import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:odc_mobile_project/navigation/routers.dart';
import 'package:shimmer/shimmer.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/ChatList/ChatListCtrl.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/ChatList/ChatPlaceholder.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/ChatList/ConversationListWidget.dart';

class ChatListPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<ChatListPage> createState() => _ChatState();
}

class _ChatState extends ConsumerState<ChatListPage> {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var ctrl = ref.read(chatListCtrlProvider.notifier);
      ctrl.getList();
    });
  }

  Future<void> refresh() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var ctrl = ref.read(chatListCtrlProvider.notifier);
      ctrl.getList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _header(refresh,context),
            _searchBar(),
            Stack(
              children: [
                _shimmer(context, ref),
                _conversationList(context, ref),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _header(refresh, BuildContext context) {
  return SafeArea(
    child: Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            onPressed: () {
              HapticFeedback.selectionClick();
              context.goNamed(Urls.accueil.name);
            },
            icon: Icon(Icons.arrow_back),
          ),
          Text(
            "Conversations",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          Container(
            padding: EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 2),
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.amber[400],
            ),
            child: ElevatedButton(
              style: ButtonStyle(
                foregroundColor: WidgetStatePropertyAll(Colors.black),
              ),
              onPressed: () {
                HapticFeedback.selectionClick();
                refresh();
              },
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.refresh,
                    //color: Colors.pink,
                    size: 25,
                  ),
                  // Text(
                  //   "Actualiser",
                  //   style: TextStyle(
                  //       fontSize: 14,
                  //       color: Colors.black,
                  //       fontWeight: FontWeight.bold),
                  // ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget _searchBar() {
  return Padding(
    padding: EdgeInsets.only(top: 16, left: 16, right: 16),
    child: TextFormField(
      autovalidateMode: AutovalidateMode.always,
      decoration: InputDecoration(
        hintText: "Rechercher...",
        hintStyle: TextStyle(color: Colors.grey.shade600),
        prefixIcon: Icon(
          Icons.search,
          color: Colors.grey.shade600,
          size: 20,
        ),
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: EdgeInsets.all(8),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey.shade100)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey.shade100)),
      ),
    ),
  );
}

Widget _conversationList(BuildContext context, WidgetRef ref) {
  var state = ref.watch(chatListCtrlProvider);

  return ListView.builder(
    itemCount: state.chatsUsers.length,
    shrinkWrap: true,
    padding: EdgeInsets.only(top: 16),
    physics: NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      return ConversationListWidget(
        chatUsersModel: state.chatsUsers[index],
      );
    },
  );
}

Widget _shimmer(BuildContext context, WidgetRef ref) {
  var state = ref.watch(chatListCtrlProvider);

  return Visibility(
    visible: state.isLoading,
    child: ListView.builder(
      itemCount: 1,
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 16),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Column(
          children: [
            Shimmer.fromColors(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ContentPlaceholder(
                    lineType: ContentLineType.twoLines,
                  ),
                  ContentPlaceholder(
                    lineType: ContentLineType.twoLines,
                  ),
                  ContentPlaceholder(
                    lineType: ContentLineType.twoLines,
                  ),
                ],
              ),
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              enabled: true,
            ),
            Center(
              child: Column(
                children: [
                  LoadingAnimationWidget.dotsTriangle(
                    color: Colors.amber,
                    size: 40,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            )
          ],
        );
      },
    ),
  );
}
