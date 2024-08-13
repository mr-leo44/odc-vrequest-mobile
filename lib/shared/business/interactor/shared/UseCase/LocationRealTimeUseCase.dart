import 'package:location/location.dart';
import 'package:odc_mobile_project/m_demande/business/model/Demande.dart';
import 'package:odc_mobile_project/m_user/business/model/User.dart';
import 'package:odc_mobile_project/shared/business/service/SharedNetworkService.dart';

class LocationRealTimeUseCase{
  SharedNetworkService network;

  LocationRealTimeUseCase(this.network);

  Map<String, dynamic> run(){
      return network.location.value;
  }
}