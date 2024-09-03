import 'package:odc_mobile_project/m_user/business/model/User.dart';
import 'package:latlong2/latlong.dart';

class ChatDetailState {
  bool isLoading;
  int isconnected;
  int isdeconnected;
  User? auth;
  List<LatLng> drawRoute;
  bool courseStarted;
  bool courseClosed;

  ChatDetailState({
    this.isLoading = false,
    this.isconnected = 0,
    this.isdeconnected = 0,
    this.auth = null,
    this.drawRoute = const <LatLng>[],
    this.courseStarted = false,
    this.courseClosed = false,
  });

  ChatDetailState copyWith({
    bool? isLoading,
    int? isconnected,
    int? isdeconnected,
    User? auth,
    List<LatLng>? drawRoute,
    bool? courseStarted,
    bool? courseClosed,
  }) =>
      ChatDetailState(
        isLoading: isLoading ?? this.isLoading,
        isconnected: isconnected ?? this.isconnected,
        isdeconnected: isdeconnected ?? this.isdeconnected,
        auth: auth ?? this.auth,
        drawRoute: drawRoute ?? this.drawRoute,
        courseStarted: courseStarted ?? this.courseStarted,
        courseClosed: courseClosed ?? this.courseClosed,
      );
}