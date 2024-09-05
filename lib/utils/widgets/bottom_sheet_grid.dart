import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:odc_mobile_project/m_chat/business/model/ChatUsersModel.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/ChatDetail/ChatDetailCtrl.dart';
import 'package:odc_mobile_project/m_course/business/Course.dart';
import 'package:odc_mobile_project/m_demande/business/model/Demande.dart';
import 'package:odc_mobile_project/shared/ui/pages/shared/SharedCtrl.dart';
import 'package:odc_mobile_project/utils/colors.dart';
import 'package:odc_mobile_project/utils/size_config.dart';
import 'package:latlong2/latlong.dart';

class BottomSheetGrid extends ConsumerStatefulWidget {
  BottomSheetGrid({
    super.key,
    required this.chatUsersModel,
    this.count = 1,
    required this.membersDialog,
    required this.vehicleDialog,
  });
  ChatUsersModel chatUsersModel;
  int count;
  Future<void> Function(
          BuildContext context, ChatUsersModel chatUsersModel, WidgetRef ref)
      membersDialog;
  Future<void> Function(
          BuildContext context, ChatUsersModel chatUsersModel, WidgetRef ref)
      vehicleDialog;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BottomSheetGridState();
}

class _BottomSheetGridState extends ConsumerState<BottomSheetGrid>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    var ctrlState = ref.watch(chatDetailCtrlProvider);
    var sharedState = ref.watch(sharedCtrlProvider);

    var pointLocation = LatLng(
      double.parse(sharedState.location["latitude"] ??
          widget.chatUsersModel.demande.latitudeDepart.toString()),
      double.parse(sharedState.location["longitude"] ??
          widget.chatUsersModel.demande.longitudelDepart.toString()),
    );
    var startPointLocation = LatLng(
        widget.chatUsersModel.demande.latitudeDepart,
        widget.chatUsersModel.demande.longitudelDepart);
    var finalPointLocation = LatLng(
        widget.chatUsersModel.demande.latitudeDestination,
        widget.chatUsersModel.demande.longitudelDestination);

    return Container(
      color: Colors.white,
      width: AppSizes.screenWidth,
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              (widget.count == 1)
                  ? GestureDetector(
                      onTap: () {
                        HapticFeedback.selectionClick();
                        _peopleDialog(context, widget.chatUsersModel, ref);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3.0, horizontal: 2.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Container(
                            color: Colors.black12,
                            height: AppSizes.screenHeight / 6.5,
                            width: AppSizes.screenWidth / 1.7,
                            child: MaterialButton(
                              onPressed: () {
                                HapticFeedback.selectionClick();
                                _peopleDialog(
                                    context, widget.chatUsersModel, ref);
                              },
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 6.0),
                                        child: Text(
                                          'Membres',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 4.0),
                                        child: Lottie.asset(
                                            "assets/animations/people-animation.json",
                                            width: 60),
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.only(bottom: 6.0),
                                      //   child: Text(
                                      //     'Details',
                                      //     style: TextStyle(fontSize: 14),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : (widget.count == 2)
                      ? GestureDetector(
                          onTap: () {
                            HapticFeedback.selectionClick();
                            _detailsDialog(context, widget.chatUsersModel, ref);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 3.0, horizontal: 2.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Container(
                                color: Colors.black12,
                                height: AppSizes.screenHeight / 6.5,
                                width: AppSizes.screenWidth / 1.7,
                                child: MaterialButton(
                                  onPressed: () {
                                    HapticFeedback.selectionClick();
                                    _detailsDialog(
                                        context, widget.chatUsersModel, ref);
                                  },
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 6.0),
                                            child: Text(
                                              'Details',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 4.0),
                                            child: Lottie.asset(
                                                "assets/animations/detail-animation.json",
                                                width: 60),
                                          ),
                                          // Padding(
                                          //   padding: const EdgeInsets.only(bottom: 6.0),
                                          //   child: Text(
                                          //     'Details',
                                          //     style: TextStyle(fontSize: 14),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Text(""),
              if (widget.count == 2)
                GestureDetector(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    _vehicleDialog(context, widget.chatUsersModel, ref);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 3.0, horizontal: 2.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Container(
                        color: Colors.black12,
                        height: AppSizes.screenHeight / 6.5,
                        width: AppSizes.screenWidth / 3,
                        child: MaterialButton(
                          onPressed: () {
                            HapticFeedback.selectionClick();
                            _vehicleDialog(context, widget.chatUsersModel, ref);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 6.0),
                                    child: Text(
                                      'Vehicule',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 13.0),
                                    child: Lottie.asset(
                                        "assets/animations/detail-animation.json",
                                        width: 60),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(bottom: 6.0),
                                  //   child: Text(
                                  //     'Details',
                                  //     style: TextStyle(fontSize: 14),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _detailsDialog(
    BuildContext context, ChatUsersModel chatUsersModel, WidgetRef ref) {
  print("Dialog Open");
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Details'),
        content: _SingleSection(
          title: "Details",
          children: [
            ListTile(
              title: Text('Ticket'),
              leading: Icon(Icons.tag),
              trailing: Text(
                chatUsersModel.demande.ticket,
                style: TextStyle(fontSize: 15),
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text('Motif'),
              leading: Icon(Icons.text_snippet_outlined),
              trailing: Text(
                chatUsersModel.demande.motif,
                style: TextStyle(fontSize: 12),
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text('Date de deplacement'),
              leading: Icon(Icons.calendar_month),
              trailing: Text(
                DateFormat('dd/MM/yyyy - HH:mm')
                    .format(chatUsersModel.demande.dateDeplacement),
                style: TextStyle(fontSize: 15),
              ),
              onTap: () {},
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.close_rounded),
          )
        ],
      );
    },
  );
}

Future<void> _vehicleDialog(
    BuildContext context, ChatUsersModel chatUsersModel, WidgetRef ref) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Vehicule'),
        content: _SingleSection(
          title: "Vehicule",
          children: [
            ListTile(
              title: Text('Plaque'),
              leading: Icon(Icons.abc),
              trailing: Text(
                chatUsersModel.course.vehicule.plaque,
                style: TextStyle(fontSize: 15),
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text('Marque'),
              leading: Icon(Icons.car_crash_outlined),
              trailing: Text(
                chatUsersModel.course.vehicule.marque,
                style: TextStyle(fontSize: 15),
              ),
              onTap: () {},
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.close_rounded),
          )
        ],
      );
    },
  );
}

Future<void> _peopleDialog(
    BuildContext context, ChatUsersModel chatUsersModel, WidgetRef ref) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Vehicule'),
        content: _SingleSection(
          title: "Membres",
          children: [
            _CustomListTile(
              ref: ref,
              avatar: "assets/images/avatar_1.png",
              textLeading: "",
              title: chatUsersModel.demande.initiateur!.email,
              subtitle: "Initiateur",
            ),
            _CustomListTile(
              ref: ref,
              avatar: "assets/images/avatar_1.png",
              textLeading: "",
              title: chatUsersModel.course.chauffeur.email,
              subtitle: "Chauffeur",
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.close_rounded),
          )
        ],
      );
    },
  );
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
