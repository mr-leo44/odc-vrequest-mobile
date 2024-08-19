import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:odc_mobile_project/m_demande/business/model/Site.dart';
import 'package:odc_mobile_project/m_demande/ui/composant/MyAutoCompleteLocation.dart';
import 'package:latlong2/latlong.dart';
import 'package:odc_mobile_project/m_demande/ui/page/map_page/MapCtrl.dart';
import 'package:proj4dart/proj4dart.dart' as proj4;

class MapPage extends ConsumerStatefulWidget {
  static const String route = '/map_controller_animated';

  const MapPage({super.key});

  @override
  MapPageState createState() => MapPageState();
}

class MapPageState extends ConsumerState<MapPage>
    with TickerProviderStateMixin {
  Alignment selectedAlignment = Alignment.topCenter;
  bool counterRotate = false;

  static const _startedId = 'AnimatedMapController#MoveStarted';
  static const _inProgressId = 'AnimatedMapController#MoveInProgress';
  static const _finishedId = 'AnimatedMapController#MoveFinished';

  static const _london = LatLng(51.5, -0.09);
  static const _paris = LatLng(48.8566, 2.3522);
  static const _dublin = LatLng(53.3498, -6.2603);
  String initText = 'Map centered to';

  // Define start center
  proj4.Point point = proj4.Point(x: 65.05166470332148, y: -19.171744826394896);

  Marker buildPin(LatLng point, Widget icon) => Marker(
        point: point,
        width: 60,
        height: 60,
        child: GestureDetector(
          onTap: () => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Tapped existing marker'),
              duration: Duration(seconds: 1),
              showCloseIcon: true,
            ),
          ),
          child: icon,
        ),
      );

  static const _markers = [
    Marker(
      width: 80,
      height: 80,
      point: _london,
      child: FlutterLogo(key: ValueKey('blue')),
    ),
    Marker(
      width: 80,
      height: 80,
      point: _dublin,
      child: FlutterLogo(key: ValueKey('green')),
    ),
    Marker(
      width: 80,
      height: 80,
      point: _paris,
      child: FlutterLogo(key: ValueKey('purple')),
    ),
  ];

  final mapController = MapController();

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.
    final camera = mapController.camera;
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

      hasTriggeredMove |= mapController.move(
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Choisir sur la carte"),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: Column(
        children: [_autoComplete(), _carte()],
      ),
    );
  }

  _carte() {
    var state = ref.watch(mapCtrlProvider);
    var depart = state.lieuDepart ??
        Site(latitude: 51.51868093513547, longitude: -0.12835376940892318);
    var destination = state.destnation ??
        Site(latitude: 53.33360293799854, longitude: -6.284001062079881);
    int movement = state.mouvement;
    late var departMarker = buildPin(LatLng(depart.latitude, depart.longitude),
        Icon(Icons.location_pin, size: 60, color: Colors.green));

    late var destinationMarker = buildPin(
        LatLng(destination.latitude, destination.longitude),
        Icon(Icons.location_pin, size: 60, color: Colors.black));
    return Flexible(
      child: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          onTap: (tapPosition, p) => setState(() {
            print("leiu : ${p.longitude}");
            initText = 'You clicked at';
            point = proj4.Point(x: p.latitude, y: p.longitude);
            if (movement == 1) {
              departMarker = buildPin(
                  p, Icon(Icons.location_pin, size: 60, color: Colors.green));
            } else {
              destinationMarker = buildPin(
                  p, Icon(Icons.location_pin, size: 60, color: Colors.black));
            }
          }),
          initialCenter: LatLng(51.5, -0.09),
          initialZoom: 7,
          maxZoom: 20,
          minZoom: 3,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'dev.fleaflet.flutter_map.example',
            tileProvider: CancellableNetworkTileProvider(),
            tileUpdateTransformer: _animatedMoveTileUpdateTransformer,
          ),
          MarkerLayer(
            markers: [departMarker, destinationMarker],
            rotate: counterRotate,
            alignment: selectedAlignment,
          ),
        ],
      ),
    );
  }

  _autoComplete() {
    var state = ref.read(mapCtrlProvider);
    var lieuDepart_ctrl = TextEditingController(text: state.lieuDepart?.nom);
    var destination_ctrl = TextEditingController(text: state.destnation?.nom);
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          MyAutoCompleteLocation(
            autoController: lieuDepart_ctrl,
            label: "Lieu du départ",
            icon: Icons.date_range,
            onTap: (location) {
              var ctrl = ref.read(mapCtrlProvider.notifier);
              ctrl.recupereLieuDepart(location);
            },
            num: 1,
            mouvement: (num) {
              var ctrl = ref.read(mapCtrlProvider.notifier);
              ctrl.changerMouvement(num);
            },
          ),
          SizedBox(
            height: 5,
          ),
          MyAutoCompleteLocation(
            autoController: destination_ctrl,
            label: "Déstination",
            icon: Icons.date_range,
            onTap: (location) {
              var ctrl = ref.read(mapCtrlProvider.notifier);
              ctrl.recpereDestination(location);
            },
            num: 2,
            mouvement: (num) {
              var ctrl = ref.read(mapCtrlProvider.notifier);
              ctrl.changerMouvement(num);
            },
          ),
        ],
      ),
    );
  }
}

final _animatedMoveTileUpdateTransformer =
    TileUpdateTransformer.fromHandlers(handleData: (updateEvent, sink) {
  final mapEvent = updateEvent.mapEvent;

  final id = mapEvent is MapEventMove ? mapEvent.id : null;
  if (id?.startsWith(MapPageState._startedId) ?? false) {
    final parts = id!.split('#')[2].split(',');
    final lat = double.parse(parts[0]);
    final lon = double.parse(parts[1]);
    final zoom = double.parse(parts[2]);

    // When animated movement starts load tiles at the target location and do
    // not prune. Disabling pruning means existing tiles will remain visible
    // whilst animating.
    sink.add(
      updateEvent.loadOnly(
        loadCenterOverride: LatLng(lat, lon),
        loadZoomOverride: zoom,
      ),
    );
  } else if (id == MapPageState._inProgressId) {
    // Do not prune or load whilst animating so that any existing tiles remain
    // visible. A smarter implementation may start pruning once we are close to
    // the target zoom/location.
  } else if (id == MapPageState._finishedId) {
    // We already prefetched the tiles when animation started so just prune.
    sink.add(updateEvent.pruneOnly());
  } else {
    sink.add(updateEvent);
  }
});
