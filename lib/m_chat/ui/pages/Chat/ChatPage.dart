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
import 'package:odc_mobile_project/m_chat/ui/pages/Chat/MediaPicker.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/ChatDetail/ChatDetailPage.dart';
import 'package:odc_mobile_project/m_user/business/model/User.dart';
import 'package:odc_mobile_project/navigation/routers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:odc_mobile_project/shared/ui/pages/shared/SharedCtrl.dart';
import 'package:odc_mobile_project/utils/colors.dart';
import 'package:video_player/video_player.dart';
import 'package:popup_menu_plus/popup_menu_plus.dart';

// ignore: must_be_immutable
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
  List<XFile>? _mediaFileList;
  PopupMenu? menu;
  GlobalKey btnKey3 = GlobalKey();

  void initState() {
    super.initState();
    newMessage.addListener(() {
      setState(() {}); // setState every time text changes
    });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var ctrl = ref.read(chatCtrlProvider.notifier);
      await ctrl.getUser();
      ctrl.realTime();
      ctrl.messageRealTime(widget.chatUsersModel);
      ctrl.getList(widget.chatUsersModel);

      var sharedCtrl = ref.read(sharedCtrlProvider.notifier);
      sharedCtrl.messageRealTime();
      sharedCtrl.realTime();
    });
  }

  @override
  void dispose() {
    newMessage.dispose();
    _disposeVideoController();
    super.dispose();
  }

  void onClickMenu(PopUpMenuItemProvider item) {
    print('Click menu -> ${item.menuTitle}');
    if (item.menuUserInfo == 'media') {
      isVideo = false;
      _onImageButtonPressed(
        ImageSource.gallery,
        context: context,
        isMultiImage: true,
        isMedia: true,
      );
    } else if (item.menuUserInfo == 'camera') {
      isVideo = false;
      _onImageButtonPressed(ImageSource.camera, context: context);
    } else {
      isVideo = false;
      _onImageButtonPressed(
        ImageSource.gallery,
        context: context,
        isMultiImage: true,
        isMedia: true,
      );
    }
  }

  void onDismiss() {
    print('Menu is dismiss');
  }

  void onShow() {
    print('Menu is show');
  }

  void _setImageFileListFromFile(XFile? value) {
    _mediaFileList = value == null ? null : <XFile>[value];
  }

  dynamic _pickImageError;
  bool isVideo = false;

  VideoPlayerController? _controller;
  VideoPlayerController? _toBeDisposed;
  String? _retrieveDataError;

  final ImagePicker _picker = ImagePicker();

  Future<void> _onImageButtonPressed(
    ImageSource source, {
    required BuildContext context,
    bool isMultiImage = false,
    bool isMedia = false,
  }) async {
    if (_controller != null) {
      await _controller!.setVolume(0.0);
    }
    if (context.mounted) {
      if (isVideo) {
        final XFile? file = await _picker.pickVideo(
            source: source, maxDuration: const Duration(seconds: 10));
        setState(() {
          _mediaFileList?.add(file!);
        });
      } else if (isMultiImage) {
        try {
          final List<XFile> pickedFileList = isMedia
              ? await _picker.pickMultipleMedia()
              : await _picker.pickMultiImage();
          setState(() {
            _mediaFileList = pickedFileList;
          });
        } catch (e) {
          setState(() {
            _pickImageError = e;
          });
        }
      } else if (isMedia) {
        try {
          final List<XFile> pickedFileList = <XFile>[];
          final XFile? media = await _picker.pickMedia();
          if (media != null) {
            pickedFileList.add(media);
            setState(() {
              _mediaFileList = pickedFileList;
            });
          }
        } catch (e) {
          setState(() {
            _pickImageError = e;
          });
        }
      } else {
        try {
          final XFile? pickedFile = await _picker.pickImage(
            source: source,
          );
          setState(() {
            _setImageFileListFromFile(pickedFile);
          });
        } catch (e) {
          setState(() {
            _pickImageError = e;
          });
        }
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MediaPicker(
            mediaFileList: _mediaFileList,
            context: context,
            chatUsersModel: widget.chatUsersModel,
          ),
        ),
      );
    }
  }

  @override
  void deactivate() {
    if (_controller != null) {
      _controller!.setVolume(0.0);
      _controller!.pause();
    }
    super.deactivate();
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
    var state = ref.watch(chatCtrlProvider);

    var resp = await ctrl.addMessage(CreerMessageRequete(
      demande: widget.chatUsersModel.demande,
      user: state.auth ??
          User(
              id: 0,
              emailVerifiedAt: DateTime.now(),
              createdAt: DateTime.now(),
              updatedAt: DateTime.now()),
      contenu: text,
    ));
    if (!resp) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Le message n\'a pas ete ajoute, veuillez reessayer svp'),
        ),
      );
    }
  }

  Future<void> _disposeVideoController() async {
    if (_toBeDisposed != null) {
      await _toBeDisposed!.dispose();
    }
    _toBeDisposed = _controller;
    _controller = null;
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      if (response.type == RetrieveType.video) {
        isVideo = true;
      } else {
        isVideo = false;
        setState(() {
          if (response.files == null) {
            _setImageFileListFromFile(response.file);
          } else {
            _mediaFileList = response.files;
          }
        });
      }
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    // final bool isLargeScreen = width > 800;
    var state = ref.watch(chatCtrlProvider);
    List<ChatModel> chatList = state.chatList.reversed.toList();
    // if (state.newMessage != null) {
    //   if (state.auth != null) {
    //      print(chatList.last.message);
    //     var actualList = chatList;
    //     print(actualList.last.message);
    //     actualList.add(
    //       ChatModel.fromJson({
    //         "user": state.newMessage?.user,
    //         "contenu": state.newMessage?.message,
    //         "type": (state.newMessage?.user.id == state.auth?.id)
    //             ? ChatMessageType.sent
    //             : ChatMessageType.received,
    //         "time": state.newMessage?.time,
    //       }),
    //     );
    //     print(actualList.last.message);
    //     chatList = actualList.reversed.toList();
    //     print(chatList.last.message);
    //   }
    // }else{
    //   chatList = state.chatList.reversed.toList();
    // }

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
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    onError: (exception, stackTrace) => Colors.white,
                    opacity: 0.8,
                    image: AssetImage("assets/images/orange.jpeg"),
                    fit: BoxFit.cover,
                  ),
                ),
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
          ),
          SafeArea(
            bottom: true,
            child: Container(
              color: Colors.transparent,
              constraints: const BoxConstraints(minHeight: 48),
              margin: EdgeInsets.only(bottom: 3, top: 3),
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
                        labelText: 'Message',
                        contentPadding: EdgeInsets.all(15),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.grey.shade100),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.grey.shade100),
                        ),
                        prefixIcon: IconButton(
                          icon: Icon(Icons.emoji_emotions_outlined),
                          onPressed: () {
                            HapticFeedback.selectionClick();
                          },
                        ),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              key: btnKey3,
                              onPressed: () {
                                HapticFeedback.selectionClick();
                                attachMenu();
                              },
                              icon: Icon(
                                Icons.attach_file,
                              ),
                            ),
                            IconButton(
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
                                HapticFeedback.selectionClick();
                                onFieldSubmitted(context);
                              },
                            ),
                          ],
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

  void attachMenu() {
    menu = PopupMenu(
      config: MenuConfig(
        // backgroundColor: Colors.green,
        lineColor: Couleurs.primary,
        highlightColor: Couleurs.primary,
      ),
      context: context,
      items: [
        PopUpMenuItem(
          title: 'Gallerie',
          image: const Icon(Icons.photo_library, color: Colors.white),
          userInfo: 'media',
        ),
        PopUpMenuItem(
          title: 'Camera',
          image: const Icon(Icons.camera_alt, color: Colors.white),
          userInfo: 'camera',
        ),
      ],
      onClickMenu: onClickMenu,
      onDismiss: onDismiss,
    );
    menu!.show(widgetKey: btnKey3);
  }
}

AppBar _appBar(BuildContext context, widget, WidgetRef ref) {
  var title = widget.chatUsersModel.demande.ticket ;

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
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
        Container(
          width: 30,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,

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
    // backgroundColor: Colors.white,
    foregroundColor: Colors.black,
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
      rippleColor: Colors.black.withAlpha(65),
      tapBehavior: TouchRippleBehavior(
        fadeInDuration: Duration(milliseconds: 250),
        eventCallBackableMinPercent: 1,
      ),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.chatUsersModel.demande.initiateur.email +
                        ", " +
                        widget.chatUsersModel.course.chauffeur.email,
                    style: TextStyle(fontSize: 12, ),
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

// ignore: must_be_immutable
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
