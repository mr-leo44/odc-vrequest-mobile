import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:odc_mobile_project/m_chat/business/model/ChatUsersModel.dart';
import 'package:odc_mobile_project/utils/size_config.dart';
import 'package:odc_mobile_project/utils/bottom_nav.dart';
import 'package:odc_mobile_project/utils/colors.dart';
import 'package:odc_mobile_project/utils/layouts/header.dart';
import 'package:shimmer/shimmer.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/ChatList/ChatListCtrl.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/ChatList/ChatPlaceholder.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/ChatList/ConversationListWidget.dart';

class ChatListPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<ChatListPage> createState() => _ChatState();
}

class _ChatState extends ConsumerState<ChatListPage> {
  final _searchKey = GlobalKey<FormState>();
  late final TextEditingController _searchController = TextEditingController();
  List<ChatUsersModel> filteredItems = [];
  late final FocusNode _focusNode = FocusNode();
  String _query = '';
  int _currentIndex = 2;
  final PageController pageController = PageController();

  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {}); // setState every time text changes
    });
    _focusNode.unfocus();
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

  void search(String query, List<ChatUsersModel> items) {
    setState(
      () {
        _query = query;

        filteredItems = items.where(
            // (item) => item.demande.initiateur!.prenom.toLowerCase().contains(
            //       query.toLowerCase(),
            //     ),
            (item) {
          String searchLabel = item.demande.ticket ;
          if (searchLabel.contains(query.toLowerCase())) {
            return true;
          } else {
            return false;
          }
        }).toList();
      },
    );
  }

  void unfocus() {
    setState(() {
      _searchController.text = "";
      filteredItems.clear();
      _query = "";
      _focusNode.unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          height: AppSizes.screenHeight,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Stack(
              children: [
                Container(
                  height: AppSizes.screenHeight,
                  child: ListView(
                    children: [
                      _header(refresh, context, ref),
                      _searchBar(_searchKey, _searchController, search, ref,
                          _focusNode, context, filteredItems, _query, unfocus),
                      Stack(
                        children: [
                          _shimmer(context, ref),
                          _conversationList(
                              context, ref, filteredItems, _query),
                        ],
                      ),
                      SizedBox(
                        height: 75,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Bottom_nav.bottomNav(
                      context, ref, _currentIndex, pageController),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _header(refresh, BuildContext context, WidgetRef ref) {
  return SafeArea(
    child: Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // IconButton(
          //   onPressed: () {
          //     HapticFeedback.selectionClick();
          //     context.goNamed(Urls.accueil.name);
          //   },
          //   icon: Icon(
          //     Icons.arrow_back,
          //     color: Colors.black,
          //   ),
          // ),
          // Text(
          //   "Conversations",
          //   style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          // ),
          Header.header(
              context,
              Text(
                "Conversations",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  // fontWeight: FontWeight.bold,
                ),
              )),
          Spacer(),
          Container(
            padding: EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 2),
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Couleurs.primary,
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

Widget _searchBar(
    _key,
    TextEditingController _controller,
    searchFunc,
    WidgetRef ref,
    FocusNode _focusNode,
    BuildContext context,
    List<ChatUsersModel> _filteredItems,
    String _query,
    unfocus) {
  var state = ref.watch(chatListCtrlProvider);

  return Padding(
    padding: EdgeInsets.only(top: 16, left: 16, right: 16),
    child: Form(
      key: _key,
      child: TextFormField(
        onChanged: (value) {
          searchFunc(value, state.chatsUsers);
        },
        focusNode: _focusNode,
        controller: _controller,
        autovalidateMode: AutovalidateMode.always,
        decoration: InputDecoration(
          hintText: "Rechercher...",
          hintStyle: TextStyle(color: Colors.grey.shade600),
          prefixIcon: _focusNode.hasFocus
              ? IconButton(
                  onPressed: unfocus,
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                )
              : Icon(
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
    ),
  );
}

Widget _conversationList(
    BuildContext context, WidgetRef ref, _filteredItems, _query) {
  var state = ref.watch(chatListCtrlProvider);

  return _filteredItems.isNotEmpty || _query.isNotEmpty
      ? _filteredItems.isEmpty
          ? Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Aucun Resultat',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Card(
                  child: Container(
                    width: double.infinity,
                    color: Colors.grey.shade100,
                    child: Padding(
                      padding: const EdgeInsets.all(6.5),
                      child: Text("Conversations"),
                    ),
                  ),
                ),
                ListView.builder(
                  itemCount: _filteredItems.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 1),
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ConversationListWidget(
                      chatUsersModel: _filteredItems[index],
                    );
                  },
                ),
              ],
            )
      : ListView.builder(
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
                    color: Couleurs.primary,
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
