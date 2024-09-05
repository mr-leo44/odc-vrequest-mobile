import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/ChatDetail/ChatDetailCtrl.dart';
import 'package:odc_mobile_project/m_course/business/Course.dart';
import 'package:odc_mobile_project/m_demande/business/model/Demande.dart';
import 'package:odc_mobile_project/shared/ui/pages/shared/SharedCtrl.dart';
import 'package:odc_mobile_project/utils/colors.dart';
import 'package:odc_mobile_project/utils/size_config.dart';
import 'package:latlong2/latlong.dart';

class BottomSheetButtonMaps extends ConsumerStatefulWidget {
  BottomSheetButtonMaps(
      {super.key,
      required this.demande,
      required this.animatedMapMove,
      required this.mapController});
  Demande demande;
  void Function(LatLng p, double zoom) animatedMapMove;
  MapController mapController;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BottomSheetCourseState();
}

class _BottomSheetCourseState extends ConsumerState<BottomSheetButtonMaps>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    var ctrlState = ref.watch(chatDetailCtrlProvider);
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

    return Container(
      color: Colors.white,
      width: AppSizes.screenWidth,
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 7.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Container(
                    color: Colors.black12,
                    height: AppSizes.screenHeight / 12,
                    width: AppSizes.screenWidth / 6,
                    child: MaterialButton(
                      onPressed: () {
                        HapticFeedback.selectionClick();

                        if (sharedState.location["longitude"] != null) {
                          widget.animatedMapMove(pointLocation, 17);
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/car.png",
                            scale: 3,
                          ),
                          Row(
                            children: [
                              Text(
                                'Vehicule',
                                style: TextStyle(fontSize: 8),
                              ),
                              SizedBox(
                                width: 1,
                              ),
                              if (sharedState.isLoading)
                                LoadingAnimationWidget.dotsTriangle(
                                  color: Couleurs.primary,
                                  size: 7,
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 3.0, horizontal: 7.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Container(
                    color: Colors.black12,
                    height: AppSizes.screenHeight / 12,
                    width: AppSizes.screenWidth / 6,
                    child: MaterialButton(
                      onPressed: () {
                        HapticFeedback.selectionClick();

                        widget.animatedMapMove(startPointLocation, 17);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.green,
                            size: 25,
                          ),
                          Text(
                            'Depart',
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 3.0, horizontal: 7.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Container(
                    color: Colors.black12,
                    height: AppSizes.screenHeight / 12,
                    width: AppSizes.screenWidth / 6,
                    child: MaterialButton(
                      onPressed: () {
                        HapticFeedback.selectionClick();

                        widget.animatedMapMove(finalPointLocation, 17);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/flag_race.png',
                            width: 25,
                          ),
                          Text(
                            'Arriver',
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 3.0, horizontal: 7.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Container(
                    color: Colors.black12,
                    height: AppSizes.screenHeight / 12,
                    width: AppSizes.screenWidth / 6,
                    child: MaterialButton(
                      onPressed: () {
                        HapticFeedback.selectionClick();

                        final bounds = LatLngBounds.fromPoints([
                          if (sharedState.location["longitude"] != null)
                            pointLocation,
                          startPointLocation,
                          finalPointLocation,
                        ]);

                        final constrained = CameraFit.bounds(
                          bounds: bounds,
                        ).fit(widget.mapController.camera);
                        widget.animatedMapMove(
                            constrained.center, constrained.zoom - 0.2);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.center_focus_strong),
                          Text(
                            'Centrer',
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
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
