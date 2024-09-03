import 'package:odc_mobile_project/m_demande/business/interactor/demandeInteractor.dart';
import 'package:odc_mobile_project/m_demande/business/model/Demande.dart';
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
    state = state.copyWith(isLoading: true, visible: true);
    var useCase = ref.watch(demandeInteractorProvider).getAllDemandeUseCase;
    var res = await useCase.run();
    if (res.length != 0) {
      int nbreDemande = res.length;
      state = state.copyWith(
          isLoading: false,
          listDemandes: res,
          isEmpty: false,
          visible: false,
          nbreDemande: nbreDemande,
          listDemandesSearch: res, notFound: true);
    } else {
      state = state.copyWith(isLoading: true, isEmpty: true, visible: true);
    }
  }

  void filtre(String recherche) async {
    List<Demande> demandes = state.listDemandes;

    List<Demande> demandesCorrespondant = demandes
        .where((demande) => demande.motif.toLowerCase().contains(recherche))
        .toList();
    state = state.copyWith(listDemandesSearch: demandesCorrespondant);

    if(demandesCorrespondant.length != 0){
      state = state.copyWith(notFound: true);
    }else{
      state = state.copyWith(notFound: false);
    }
  }
}
