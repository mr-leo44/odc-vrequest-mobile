import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:odc_mobile_project/m_demande/ui/composant/MyAutoCompletion.dart';
import 'package:odc_mobile_project/m_demande/ui/page/map_page/keys.dart';

class MapPage extends ConsumerStatefulWidget {
  const MapPage({super.key});

  @override
  ConsumerState createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage> {
  Set<Marker> markers = {};
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-4.43296265331129, 15.08832357078792),
    zoom: 14.4746,
  );
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _contenuPrincipale(context, ref),
    );
  }

  _contenuPrincipale(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        GoogleMap(
          markers: markers,
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          onTap: (latLong) {
            setState(() {
              markers.add(Marker(
                markerId: MarkerId("0"),
                position: latLong,
                infoWindow: InfoWindow(
                  title: 'I am a marker',
                ),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueMagenta),
              ));
            });
          },
        ),
        Container(
            width: double.infinity,
            height: 250,
            color: Colors.white.withOpacity(0.5),
            margin: EdgeInsets.only(top: 50, right: 20, left: 20),
            child: Column(
                children: [
                Text("Adresses"),
            MyAutoCompletion(apiKey: APIKeys.androidApiKey,
                label: "Lieu de départ",
                icon: Icons.looks_one),
            SizedBox(height: 12,),
            MyAutoCompletion(apiKey: APIKeys.androidApiKey,
                label: "Déstination",
                icon: Icons.looks_two),
            SizedBox(height: 20,),
            ElevatedButton.icon(
              onPressed: () {
Navigator.pop(context);
              },
              label: Text(
                "Enregistrer",
                style: TextStyle(fontSize: 20),
              ),
              icon: Icon(Icons.send),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            )
      ],
    ),)
    ]
    ,
    );
  }
}
