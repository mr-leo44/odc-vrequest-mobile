import 'package:odc_mobile_project/m_chat/business/service/messageNetworkService.dart';
import 'package:latlong2/latlong.dart';

class GetRouteUrlUseCase{
  MessageNetworkService network;

  GetRouteUrlUseCase(this.network);

  Future<List<LatLng>>run(String startPoint, String endPoint)async{
    return await network.getRouteUrl(startPoint, endPoint);
  }
}