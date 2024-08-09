import 'dart:convert';

import 'package:location/location.dart';
import 'package:odc_mobile_project/m_demande/business/model/Demande.dart';
import 'package:odc_mobile_project/shared/business/service/SharedNetworkService.dart';

class SendLocationUseCase{
  SharedNetworkService network;

  SendLocationUseCase(this.network);

  Future<void> run(Map<String, dynamic> location, Demande demande) async{
    await network.sendLocation(location , demande );
  }
}