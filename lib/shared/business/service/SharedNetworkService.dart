import 'package:location/location.dart';
import 'package:odc_mobile_project/m_demande/business/model/Demande.dart';
import 'package:odc_mobile_project/m_user/business/model/User.dart';
import 'package:signals/signals_flutter.dart';

abstract class SharedNetworkService{
  Signal<Map<String, dynamic>> location = Signal(<String, dynamic>{});

  Future<void> sendLocation(Map<String, dynamic> location, Demande demande);
  Future<void> getLocation(Demande demande, User? auth);
}