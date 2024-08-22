import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/ChatDetail/ChatDetailCtrl.dart';
import 'package:odc_mobile_project/m_demande/business/model/Demande.dart';
import 'package:odc_mobile_project/shared/ui/pages/shared/SharedCtrl.dart';
import 'package:odc_mobile_project/utils/misc/tile_providers.dart';
import 'package:odc_mobile_project/utils/plugins/zoombuttons_plugin.dart';
import 'package:latlong2/latlong.dart';

typedef HitValue = ({String title, String subtitle});

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
  double sizeMap = 300 ;

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var ctrl = ref.read(chatDetailCtrlProvider.notifier);
      var sharedCtrl = ref.read(sharedCtrlProvider.notifier);

      var sharedState = ref.watch(sharedCtrlProvider);
      print("Longitude: ${sharedState.location["longitude"]}");
      await ctrl.getRouteUrl(
          "${sharedState.location["longitude"]},${sharedState.location["latitude"]}",
          "${widget.demande.longitudelDestination},${widget.demande.latitudeDestination}");
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

  @override
  Widget build(BuildContext context) {
    var sharedState = ref.watch(sharedCtrlProvider);
    var pointLocation = LatLng(
      double.parse(sharedState.location["latitude"] ??
          widget.demande.latitudeDepart.toString()),
      double.parse(sharedState.location["longitude"] ??
          widget.demande.longitudelDepart.toString()),
    );
    var startPointLocation =
        LatLng(widget.demande.latitudeDepart, widget.demande.longitudelDepart);
    var finalPointLocation = LatLng(widget.demande.latitudeDestination,
        widget.demande.longitudelDestination);

    var customMarkers = <Marker>[
      if(sharedState.location["longitude"] != null)
      buildPin(pointLocation, Image.asset("images/car.png")),

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
        Icon(
          Icons.flag,
          size: 40,
          color: Colors.red,
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

    var ctrlState = ref.watch(chatDetailCtrlProvider);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MaterialButton(
              onPressed: () {
                HapticFeedback.selectionClick();

                if(sharedState.location["longitude"] != null){
                  _animatedMapMove(pointLocation, 17);
                }
              },
              child: Column(
                children: [
                  Image.asset(
                    "images/car.png",
                    width: 25,
                  ),
                  Row(
                    children: [
                      Text(
                        'Vehicule',
                        style: TextStyle(fontSize: 10),
                      ),
                      if (sharedState.isLoading)
                        SizedBox(
                          width: 3,
                        ),
                      if (sharedState.isLoading)
                        LoadingAnimationWidget.dotsTriangle(
                          color: Colors.amber,
                          size: 10,
                        ),
                    ],
                  ),
                ],
              ),
            ),
            MaterialButton(
              onPressed: () {
                HapticFeedback.selectionClick();

                _animatedMapMove(startPointLocation, 17);
              },
              child: Column(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.green,
                  ),
                  Text(
                    'Point de depart',
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ),
            MaterialButton(
              onPressed: () {
                HapticFeedback.selectionClick();

                _animatedMapMove(finalPointLocation, 17);
              },
              child: Column(
                children: [
                  Icon(
                    Icons.flag,
                    color: Colors.red,
                  ),
                  Text(
                    'Point d\'arriver',
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ),
            MaterialButton(
              onPressed: () {
                HapticFeedback.selectionClick();

                final bounds = LatLngBounds.fromPoints([
                  if(sharedState.location["longitude"] != null)
                  pointLocation,
                  
                  startPointLocation,
                  finalPointLocation,
                ]);

                final constrained = CameraFit.bounds(
                  bounds: bounds,
                ).fit(_mapController.camera);
                _animatedMapMove(constrained.center, constrained.zoom - 0.2);
              },
              child: Column(
                children: [
                  Icon(Icons.center_focus_strong),
                  Text(
                    'Centrer',
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: sizeMap,
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
        ),
        Card(
          child: Column(
            children: [
              ListTile(title: Text('Defiler a l\'interieur de la carte')),
              ListTile(
                title: (sizeMap >= 500) ? Text('Retraicir') : Text('Agrandir'),
                trailing: MaterialButton(
                  onPressed: () {
                    HapticFeedback.selectionClick();
                    setState(() {
                      if(sizeMap >= 500){
                        sizeMap = 300;
                      }else{
                        sizeMap = 500;
                      }
                      
                    });
                  },
                  child: (sizeMap >= 500) ? Icon(Icons.splitscreen) : Icon(Icons.fit_screen)  ,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
