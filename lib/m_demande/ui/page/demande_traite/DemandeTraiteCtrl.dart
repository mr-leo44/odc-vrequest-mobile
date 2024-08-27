
import 'package:odc_mobile_project/m_demande/business/interactor/demandeInteractor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'DemandeTraiteState.dart';

part 'DemandeTraiteCtrl.g.dart';

@riverpod
class DemandeTraiteCtrl extends _$DemandeTraiteCtrl {
  @override
 DemandeTraiteState build() {
    return DemandeTraiteState();
  }

  void recupererListDemande() async {
    state = state.copyWith(isLoading: true, isEmpty: true);
    var useCase = ref
        .watch(demandeInteractorProvider)
        .getDemandeTraiteUseCase;
    var res = await useCase.run();
    if (res.length != 0) {
      int nbreDemande = res.length;
      state = state.copyWith(isLoading: false, listDemandes: res, isEmpty: false, nbreDemande: nbreDemande);
    }else{
      state = state.copyWith(isLoading: true, isEmpty: true);
    }
  }
}