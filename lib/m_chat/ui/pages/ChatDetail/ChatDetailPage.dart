import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:odc_mobile_project/m_chat/business/model/ChatUsersModel.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/Chat/ChatPage.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/ChatDetail/ChatDetailCtrl.dart';
import 'package:flutter/cupertino.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/ChatDetail/ChatMaps.dart';
import 'package:odc_mobile_project/shared/ui/pages/shared/SharedCtrl.dart';

class ChatDetailPage extends ConsumerStatefulWidget {
  ChatUsersModel chatUsersModel;

  ChatDetailPage({required this.chatUsersModel});

  @override
  ConsumerState<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends ConsumerState<ChatDetailPage> {
  bool canSwitch = false;

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var ctrl = ref.read(chatDetailCtrlProvider.notifier);
      await ctrl.getUser();
      ctrl.stateConnection();

      var sharedCtrl = ref.read(sharedCtrlProvider.notifier);
      await sharedCtrl.requestLocationPermission();
      await listenLocation();
      await sharedCtrl.getLocation(widget.chatUsersModel.demande);
      await sharedCtrl.locationRealTime();
    });
  }

  Future<void> listenLocation() async {
    var state = ref.watch(chatDetailCtrlProvider);
    var auth = state.auth?.role;

    if (auth != null && auth.any((e) => e.contains('chauffeur'))) {
      var sharedCtrl = ref.read(sharedCtrlProvider.notifier);
      await sharedCtrl.listenLocation(widget.chatUsersModel.demande);
    }
  }

  @override
  Widget build(BuildContext context) {
    var sharedState = ref.watch(sharedCtrlProvider);
    print(sharedState.location);
    var auth = sharedState.auth?.role;

    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      appBar: _appBar(context, widget, ref),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Builder(
          builder: (BuildContext context) {
            return CustomScrollView(
              slivers: <Widget>[
                SliverPadding(
                  padding: const EdgeInsets.all(8.0),
                  sliver: SliverFillRemaining(
                    child: Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 400),
                        child: ListView(
                          children: [
                            _SingleSection(
                              title: "Tracking",
                              children: [
                                Stack(
                                  children: [
                                    Visibility(
                                      visible: !sharedState.isLoading,
                                      child: ChatMaps(
                                          demande:
                                              widget.chatUsersModel.demande),
                                    ),
                                    Visibility(
                                      visible: sharedState.isLoading,
                                      child: Padding(
                                        padding: const EdgeInsets.all(58.0),
                                        child: Column(
                                          children: [
                                            LoadingAnimationWidget.dotsTriangle(
                                              color: Colors.amber,
                                              size: 40,
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text("Initialisation...")
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            _SingleSection(
                              title: "Details",
                              children: [
                                ListTile(
                                  title: Text('Ticket'),
                                  leading: Icon(Icons.tag),
                                  trailing: Text(
                                    widget.chatUsersModel.demande.ticket,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  onTap: () {},
                                ),
                                ListTile(
                                  title: Text('Motif'),
                                  leading: Icon(Icons.text_snippet_outlined),
                                  trailing: Text(
                                    widget.chatUsersModel.demande.motif,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  onTap: () {},
                                ),
                                ListTile(
                                  title: Text('Date de deplacement'),
                                  leading: Icon(Icons.calendar_month),
                                  trailing: Text(
                                    DateFormat('dd/MM/yyyy - HH:mm').format(
                                        widget.chatUsersModel.demande
                                            .dateDeplacement),
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  onTap: () {},
                                ),
                                if (auth != null && auth.any((e) => e.contains('chauffeur')))
                                ListTile(
                                  title: Text("Status"),
                                  leading: Icon(Icons.start),
                                  trailing: CupertinoSwitch(
                                      value: canSwitch,
                                      onChanged: (val) {
                                        HapticFeedback.selectionClick();
                                        
                                        setState(() {
                                          if (canSwitch == true) {
                                            canSwitch = false;
                                          } else {
                                            canSwitch = true;
                                          }
                                        });
                                      }),
                                  onTap: () {},
                                ),
                              ],
                            ),
                            _SingleSection(
                              title: "Membres",
                              children: [
                                _CustomListTile(
                                  ref: ref,
                                  avatar: "assets/images/avatar_1.png",
                                  textLeading: "",
                                  title: widget
                                      .chatUsersModel.demande.initiateur!.email,
                                  subtitle: "Initiateur",
                                ),
                                _CustomListTile(
                                  ref: ref,
                                  avatar: "assets/images/avatar_1.png",
                                  textLeading: "",
                                  title: widget
                                      .chatUsersModel.demande.chauffeur!.email,
                                  subtitle: "Chauffeur",
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

AppBar _appBar(BuildContext context, widget, WidgetRef ref) {
  return AppBar(
    leadingWidth: 80,
    automaticallyImplyLeading: true,
    leading: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                chatUsersModel: widget.chatUsersModel,
              ),
            ),
          ),
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
    title: Padding(
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.chatUsersModel.demande.ticket,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          // Row(
          //   children: [
          //     Expanded(
          //       child: Text(
          //         widget.chatUsersModel.demande.initiateur.username +
          //             ", " +
          //             widget.chatUsersModel.demande.chauffeur.username,
          //         style: TextStyle(fontSize: 12),
          //         softWrap: false,
          //         overflow: TextOverflow.ellipsis,
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    ),
    actions: [],
  );
}

class _CustomListTile extends StatelessWidget {
  final String title;
  final String textLeading;
  final String avatar;
  final String subtitle;
  final WidgetRef ref;

  _CustomListTile({
    required this.ref,
    required this.title,
    required this.textLeading,
    this.avatar = "",
    this.subtitle = "",
  });

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(chatDetailCtrlProvider);

    if (avatar.isEmpty) {
      return Column(
        children: [
          ListTile(
            title: Text(title),
            leading: Text(textLeading + " :"),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          ListTile(
            title: Row(
              children: [
                Text(title),
                SizedBox(
                  width: 5,
                ),
                if ((subtitle.isNotEmpty) &&
                    (state.isconnected == state.auth?.id))
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 5,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: Container(
                        width: 15,
                        margin: EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                            color: Colors.green, shape: BoxShape.circle),
                      ),
                    ),
                  )
              ],
            ),
            subtitle: Text(subtitle),
            leading: CircleAvatar(
              backgroundImage: AssetImage(avatar),
            ),
          ),
        ],
      );
    }
  }
}

class _SingleSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _SingleSection({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title.toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontSize: 16),
          ),
        ),
        Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}
