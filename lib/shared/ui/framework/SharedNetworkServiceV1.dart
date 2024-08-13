import 'package:location_platform_interface/location_platform_interface.dart';
import 'package:odc_mobile_project/m_demande/business/model/Demande.dart';
import 'package:odc_mobile_project/m_user/business/model/User.dart';
import 'package:odc_mobile_project/shared/business/service/SharedNetworkService.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:signals/signals_flutter.dart';

class SharedNetworkServiceV1 implements SharedNetworkService{
  SharedNetworkServiceV1(this.socket);
  Socket socket;
  Signal<Map<String, dynamic>> location = Signal(<String, dynamic>{});

  @override
  Future<void> sendLocation(Map<String, dynamic> location, Demande demande) async {
    if (socket.connected) {
      socket.emit('test', 'testSendLocation');
      
      var donnees = {
        "location" : location,
        "demande": demande,
      };
      
      socket.emit('sendLocation', donnees);
    }
  }
  
  @override
  Future<void> getLocation(Demande demande, User? auth) async {
    if (socket.connected) {
      socket.emit('test', 'testGetLocation');
      socket.on('getLocation', (resp) {
        if ((auth != null) && (resp["demande"]["id"] == demande.id)) {
          location.value = resp["location"];
        }
      });
    }
  }


}