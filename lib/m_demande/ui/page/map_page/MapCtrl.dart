import 'package:odc_mobile_project/m_demande/business/model/Site.dart';
import 'package:odc_mobile_project/m_demande/ui/page/map_page/MapState.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'MapCtrl.g.dart';

@Riverpod(keepAlive: true)
class MapCtrl extends _$MapCtrl {
  @override
  MapState build() {
    return MapState();
  }

  void recupereLieuDepart(Site site) {
    state = state.copyWith(isSelectDepart: true, lieuDepart: site);
  }

  void recupereDestination(Site site) {
    state = state.copyWith(isSelectDestination: true, destination: site);
  }

  void changerMouvement(int num) {
    state = state.copyWith(mouvement: num);
  }

  void renitialiserPage(){
    state = state.copyWith(
      isSelectDepart: false,
      isSelectDestination: false,
      lieuDepart: null,
      destination: null,
    );
  }
}
