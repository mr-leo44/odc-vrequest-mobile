
import 'package:odc_mobile_project/m_demande/business/interactor/demandeInteractor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'DemandeListState.dart';
part 'DemandeListCtrl.g.dart';

@riverpod
class DemandeListCtrl extends _$DemandeListCtrl {
  @override
  DemandeListState build() {
    return DemandeListState();
  }

  void recupererListDemande() async {
    state = state.copyWith(isLoading: true, isEmpty: true);
    var useCase = ref
        .watch(demandeInteractorProvider)
        .getAllDemandeUseCase;
    var res = await useCase.run();
    if (res.length != 0) {
      state = state.copyWith(isLoading: false, listDemandes: res, isEmpty: false);
    }else{
      state = state.copyWith(isLoading: true, isEmpty: true);
    }
  }
}