import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart' as Lott;
import 'package:odc_mobile_project/m_chat/business/model/ChatUsersModel.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/Chat/ChatPage.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/ChatDetail/ChatDetailCtrl.dart';
import 'package:flutter/cupertino.dart';
import 'package:odc_mobile_project/shared/ui/pages/shared/SharedCtrl.dart';
import 'package:odc_mobile_project/utils/colors.dart';

import 'package:latlong2/latlong.dart';
import 'package:odc_mobile_project/utils/misc/tile_providers.dart';
import 'package:odc_mobile_project/utils/plugins/zoombuttons_plugin.dart';
import 'package:odc_mobile_project/utils/widgets/bottom_sheet_button_maps.dart';
import 'package:odc_mobile_project/utils/widgets/bottom_sheet_course.dart';
import 'package:odc_mobile_project/utils/widgets/bottom_sheet_dummy_ui.dart';
import 'package:odc_mobile_project/utils/widgets/bottom_sheet_grid.dart';
import 'package:odc_mobile_project/utils/widgets/draggable_sheet.dart';

typedef HitValue = ({String title, String subtitle});

class ChatDetailPage extends ConsumerStatefulWidget {
  ChatUsersModel chatUsersModel;

  ChatDetailPage({required this.chatUsersModel});

  @override
  ConsumerState<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends ConsumerState<ChatDetailPage>
    with TickerProviderStateMixin {
  Alignment selectedAlignment = Alignment.topCenter;
  bool counterRotate = false;

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

      var sharedState = ref.watch(sharedCtrlProvider);
      print("Longitude: ${sharedState.location["longitude"]}");
      await ctrl.getRouteUrl(
          widget.chatUsersModel.demande.longitudelDestination,
          widget.chatUsersModel.demande.latitudeDestination);

      var ctrlState = ref.watch(chatDetailCtrlProvider);
      ctrlState.courseStarted =
          (widget.chatUsersModel.course.startedAt != null) ? true : false;
      ctrlState.courseClosed =
          (widget.chatUsersModel.course.endedAt != null) ? true : false;
    });
  }

  static final MapController _mapController = MapController();

  Marker buildPin(LatLng point, Widget marker) => Marker(
        point: point,
        width: 60,
        height: 60,
        child: GestureDetector(
          onTap: () => _animatedMapMove(point, 17),
          child: marker,
        ),
      );

  static const _startedId = 'AnimatedMapController#MoveStarted';
  static const _inProgressId = 'AnimatedMapController#MoveInProgress';
  static const _finishedId = 'AnimatedMapController#MoveFinished';

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.
    final camera = _mapController.camera;
    final latTween = Tween<double>(
        begin: camera.center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(
        begin: camera.center.longitude, end: destLocation.longitude);
    final zoomTween = Tween<double>(begin: camera.zoom, end: destZoom);

    // Create a animation controller that has a duration and a TickerProvider.
    final controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    // The animation determines what path the animation will take. You can try different Curves values, although I found
    // fastOutSlowIn to be my favorite.
    final Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    // Note this method of encoding the target destination is a workaround.
    // When proper animated movement is supported (see #1263) we should be able
    // to detect an appropriate animated movement event which contains the
    // target zoom/center.
    final startIdWithTarget =
        '$_startedId#${destLocation.latitude},${destLocation.longitude},$destZoom';
    bool hasTriggeredMove = false;

    controller.addListener(() {
      final String id;
      if (animation.value == 1.0) {
        id = _finishedId;
      } else if (!hasTriggeredMove) {
        id = startIdWithTarget;
      } else {
        id = _inProgressId;
      }

      hasTriggeredMove |= _mapController.move(
        LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
        zoomTween.evaluate(animation),
        id: id,
      );
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  Future<void> listenLocation() async {
    var state = ref.watch(chatDetailCtrlProvider);
    var auth = state.auth?.role;

    if (auth != null && auth.any((e) => e.contains('chauffeur'))) {
      var sharedCtrl = ref.read(sharedCtrlProvider.notifier);
      await sharedCtrl.listenLocation(widget.chatUsersModel.demande);
    }
  }

  Future<void> startCourse() async {
    var ctrl = ref.read(chatDetailCtrlProvider.notifier);
    var started = await ctrl.startCourse(widget.chatUsersModel.course);
    Widget display;
    if (started) {
      display = Text('Le debut de la course a ete signale avec succes');
    } else {
      display = Text('La course a deja commence');
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: display,
      ),
    );
  }

  Future<void> closeCourse() async {
    var ctrl = ref.read(chatDetailCtrlProvider.notifier);
    var started = await ctrl.closeCourse(widget.chatUsersModel.course);
    Widget display;
    if (started) {
      display = Text('La fin de la course a ete signale avec succes');
    } else {
      display = Text('La course est deja termine');
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: display,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var sharedState = ref.watch(sharedCtrlProvider);
    print(sharedState.location);

    var ctrlState = ref.watch(chatDetailCtrlProvider);

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

    var customMarkers = <Marker>[
      if (sharedState.location["longitude"] != null)
        buildPin(
            pointLocation,
            Image.asset(
              "images/car.png",
              width: 40,
            )),
      buildPin(
        startPointLocation,
        Icon(
          Icons.location_on,
          color: Colors.green,
          size: 40,
        ),
      ),
      buildPin(
        finalPointLocation,
        Image.asset(
          'assets/icons/flag_race.png',
          width: 40,
        ),
      ),
    ];

    final _polylinesRaw = <Polyline<HitValue>>[
      Polyline(
        points: [
          pointLocation,
          finalPointLocation,
        ],
        strokeWidth: 10,
        color: Colors.orange,
        pattern: StrokePattern.dotted(
          spacingFactor: 3,
        ),
        borderStrokeWidth: 8,
        borderColor: Colors.blue.withOpacity(0.5),
      ),
    ];
    late final _polylines =
        Map.fromEntries(_polylinesRaw.map((e) => MapEntry(e.hitValue, e)));

    return Scaffold(
      // backgroundColor: const Color(0xfff6f6f6),
      appBar: _appBar(context, widget, ref),
      body: Stack(
        children: [
          _map(_mapController),
          _bottomSheet(),
        ],
      ),
    );
  }

  Widget _map(MapController _mapController) {
    var sharedState = ref.watch(sharedCtrlProvider);
    print(sharedState.location);

    var ctrlState = ref.watch(chatDetailCtrlProvider);

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

    var customMarkers = <Marker>[
      if (sharedState.location["longitude"] != null)
        buildPin(
            pointLocation,
            Image.asset(
              "images/car.png",
              width: 40,
            )),
      buildPin(
        startPointLocation,
        Icon(
          Icons.location_on,
          color: Colors.green,
          size: 40,
        ),
      ),
      buildPin(
        finalPointLocation,
        Image.asset(
          'assets/icons/flag_race.png',
          width: 40,
        ),
      ),
    ];

    final _polylinesRaw = <Polyline<HitValue>>[
      Polyline(
        points: [
          pointLocation,
          finalPointLocation,
        ],
        strokeWidth: 10,
        color: Colors.orange,
        pattern: StrokePattern.dotted(
          spacingFactor: 3,
        ),
        borderStrokeWidth: 8,
        borderColor: Colors.blue.withOpacity(0.5),
      ),
    ];
    late final _polylines =
        Map.fromEntries(_polylinesRaw.map((e) => MapEntry(e.hitValue, e)));

    return Container(
      height: double.infinity ,
      child: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: pointLocation,
          initialZoom: 17,
        ),
        children: [
          openStreetMapTileLayer,
          MarkerLayer(
            markers: customMarkers,
            rotate: counterRotate,
            alignment: selectedAlignment,
          ),
          const FlutterMapZoomButtons(
            zoomInColor: Colors.black,
            zoomInColorIcon: Colors.white,
            zoomOutColor: Colors.black,
            zoomOutColorIcon: Colors.white,
            minZoom: 4,
            maxZoom: 19,
            mini: true,
            padding: 10,
            alignment: Alignment.topRight,
          ),
          PolylineLayer(
            polylines: [
              Polyline(
                  points: ctrlState.drawRoute,
                  color: Colors.blue.withOpacity(0.5),
                  strokeWidth: 8),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bottomSheet() {
    var sharedState = ref.watch(sharedCtrlProvider);
    print(sharedState.location);
    var auth = sharedState.auth?.role;

    return MyDraggableSheet(
      child: Column(
        children: [
          if (auth != null && auth.any((e) => e.contains('chauffeur')))
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: BottomSheetCourse(
                  course: widget.chatUsersModel.course,
                ),
              ),
            ),
          SizedBox(height: 1),
          BottomSheetButtonMaps(
            demande: widget.chatUsersModel.demande,
            animatedMapMove: _animatedMapMove,
            mapController: _mapController,
          ),
          BottomSheetGrid(
            chatUsersModel: widget.chatUsersModel,
            count: 2,
            vehicleDialog: _vehicleDialog,
            membersDialog: _peopleDialog,
          ),
          BottomSheetGrid(
            chatUsersModel: widget.chatUsersModel,
            vehicleDialog: _vehicleDialog,
            membersDialog: _peopleDialog,
          ),
        ],
      ),
    );
  }
}

AppBar _appBar(BuildContext context, widget, WidgetRef ref) {
  var title = widget.chatUsersModel.demande.ticket;

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
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    title: Padding(
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
          Text(
            'Detail',
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    ),
    actions: [],
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

Future<void> _startCourseDialog(
    BuildContext context, WidgetRef ref, startCourse) {
  var ctrlState = ref.watch(chatDetailCtrlProvider);

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Debuter la course'),
        content: const Text(
          'Etes-vous sur de vouloir debuter la course maintenant ?',
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Non'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Oui'),
            onPressed: () {
              if ((!ctrlState.courseStarted) && (!ctrlState.courseClosed)) {
                startCourse();
              } else if (ctrlState.courseStarted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("La course a deja commence"),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        "On peut pas recommencer une course qui a deja ete termine"),
                  ),
                );
              }
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> _closeCourseDialog(
    BuildContext context, WidgetRef ref, closeCourse) {
  var ctrlState = ref.watch(chatDetailCtrlProvider);

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Terminer la course'),
        content: const Text(
          'Etes-vous sur de vouloir terminer la course maintenant ?',
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Non'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Oui'),
            onPressed: () {
              if ((ctrlState.courseStarted) && (!ctrlState.courseClosed)) {
                closeCourse();
              } else if (ctrlState.courseClosed) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("La course est deja termine"),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        "On peut pas terminer une course qui n'a pas encore commence"),
                  ),
                );
              }
              Navigator.of(context).pop();
            },
          ),
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
