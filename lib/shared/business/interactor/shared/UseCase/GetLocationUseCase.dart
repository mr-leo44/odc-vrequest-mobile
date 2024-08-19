import 'package:odc_mobile_project/m_demande/business/model/Demande.dart';
import 'package:odc_mobile_project/m_user/business/model/User.dart';
import 'package:odc_mobile_project/shared/business/service/SharedNetworkService.dart';

class GetLocationUseCase{
  SharedNetworkService network;

  GetLocationUseCase(this.network);

  Future<void> run(Demande demande, User? auth) async{
    await network.getLocation(demande, auth);
  }
}