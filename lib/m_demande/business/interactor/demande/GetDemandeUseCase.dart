import '../../../../m_user/business/service/userLocalService.dart';
import '../../model/Demande.dart';
import '../../service/DemandeLocalService.dart';
import '../../service/DemandeNetworkService.dart';

class GetDemandeUseCase {
  DemandeNetworkService network;
  UserLocalService userLocal;

  GetDemandeUseCase(this.network, this.userLocal);

  Future<Demande> run(int id) async {
    String token = await userLocal.getToken();
    var res = await network.getDemande(id, token);
    return res;
  }
}
