import 'package:odc_mobile_project/m_demande/business/model/Demande.dart';
import 'package:odc_mobile_project/m_demande/business/model/Site.dart';
import 'package:odc_mobile_project/m_demande/ui/page/details_demande_page/DetailsDemandeState.dart';
import 'package:odc_mobile_project/m_demande/ui/page/map_page/GlobalMapState.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'GlobalMapCtrl.g.dart';
@Riverpod(keepAlive: true)
class GlobalMapCtrl extends _$GlobalMapCtrl {
  @override
  GlobalMapState build() {
    return GlobalMapState();
  }

void recupereLieuDepart(Site site){
    state = state.copyWith(isSelectDepart: true, lieuDepart: site);
}

void recpereDestination(Site site){
    // state = state.copyWith(isSelectDestination: true, destnation: site);
}

}