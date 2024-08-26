import 'package:odc_mobile_project/m_demande/business/interactor/demandeInteractor.dart';
import 'package:odc_mobile_project/m_demande/business/model/Demande.dart';
import 'package:odc_mobile_project/m_demande/ui/page/details_demande_page/DetailsDemandeState.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'DetailsDemandeCtrl.g.dart';

@riverpod
class DetailsDemandeCtrl extends _$DetailsDemandeCtrl {
  @override
  DetailsDemandeState build() {
    return DetailsDemandeState();
  }

  void recupererDemande(int id) async {
    state = state.copyWith(isLoading: true);
    var useCase = ref.watch(demandeInteractorProvider).getDemandeUseCase;
    var res = await useCase.run(id);
    if (res != null) {
      state = state.copyWith(demande: res, isLoading: false);
      print("updated state ${res.initiateur!.nom}");
    } else {
      state = state.copyWith(isEmpty: true);
    }
  }

  void annulerDemande(int id) async {
    var useCase = ref.watch(demandeInteractorProvider).annulerDemandeUseCase;
    var res = await useCase.run(id);
  }
}
