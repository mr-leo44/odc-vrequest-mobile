import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/ChatDetail/ChatDetailCtrl.dart';
import 'package:odc_mobile_project/m_demande/business/model/Demande.dart';
import 'package:odc_mobile_project/shared/ui/pages/shared/SharedCtrl.dart';
import 'package:odc_mobile_project/utils/misc/tile_providers.dart';
import 'package:odc_mobile_project/utils/plugins/zoombuttons_plugin.dart';
import 'package:latlong2/latlong.dart';

class ChatMaps extends ConsumerStatefulWidget {
  Demande demande;
  ChatMaps({required this.demande});

  @override
  ConsumerState<ChatMaps> createState() => _ChatMapsState();
}

class _ChatMapsState extends ConsumerState<ChatMaps>
    with TickerProviderStateMixin {
  Alignment selectedAlignment = Alignment.topCenter;
  bool counterRotate = false;

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var sharedCtrl = ref.read(sharedCtrlProvider.notifier);
    });
  }

  static const alignments = {
    315: Alignment.topLeft,
    0: Alignment.topCenter,
    45: Alignment.topRight,
    270: Alignment.centerLeft,
    null: Alignment.center,
    90: Alignment.centerRight,
    225: Alignment.bottomLeft,
    180: Alignment.bottomCenter,
    135: Alignment.bottomRight,
  };

  static final MapController _mapController = MapController();

  Marker buildPin(LatLng point, Color color) => Marker(
        point: point,
        width: 60,
        height: 60,
        child: GestureDetector(
          child: Icon(Icons.location_pin, size: 60, color: color),
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

  @override
  Widget build(BuildContext context) {
    var sharedState = ref.watch(sharedCtrlProvider);
    var pointLocation = LatLng(
        double.parse(sharedState.location["latitude"] ?? "51.51868093513547"),
        double.parse(
            sharedState.location["longitude"] ?? "-0.12835376940892318"));

    var customMarkers = <Marker>[
      // buildPin(
      //     const LatLng(51.51868093513547, -0.12835376940892318), Colors.green),
      buildPin(pointLocation, Colors.green),
    ];

    // final bounds = LatLngBounds.fromPoints([
    //   pointLocation,
    // ]);

    return Column(
      children: [
        MaterialButton(
          onPressed: () => _animatedMapMove(pointLocation, 17),
          child: Icon(Icons.location_searching ),
        ),
        SizedBox(
          height: 300,
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
                alignment: Alignment.bottomLeft,
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            children: [
              ListTile(title: Text('Scrolling inside the map')),
            ],
          ),
        ),
      ],
    );
  }
}
